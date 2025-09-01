$(document).ready(() => {
    var analysing = false;
    var timeOuts = [];
    var tabletType = null;

    const methods = {
        open: ({ hasNearest, type }) => {
            tabletType = type;

            $("#evidence").fadeIn(100);
            $("#starting span").text("Preparando o sistema...")
            $("#starting").fadeIn(500);

            timeOuts.push(setTimeout(() => {
                if (hasNearest) {
                    $("#starting").fadeOut();

                    timeOuts.push(setTimeout(() => {
                        $("#initial").fadeIn(500);
                        $(".right").html(`
                            <button id="analysis">Iniciar Análise</button>
                        `)
                    }, 500));
                } else {
                    $("#starting span").text("Você não está próximo de um cidadão...")

                    timeOuts.push(setTimeout(() => {
                        Close();
                    }, 2500));
                }
            }, 2000));
        }
    }

    window.addEventListener("message", (event) => {
        const { action } = event.data;
        if (methods[action]) methods[action](event.data);
    })

    document.onkeyup = (event) => {
        if (event.key == "Escape" && !analysing) Close();
    }

    $(document).on("click", "#analysis", function () {
        analysing = true;

        $(".border-top").css("animation", "fade-border 1.5s linear infinite")
        $(".border-bottom").css("animation", "fade-border 1.5s linear infinite")
        $(".image img").css("animation", "fade 1.5s linear infinite")

        $(".right").html(`
            <i class="fa-solid fa-spinner"></i>
            <span>Verificando cidadão próximo...</span>
        `)

        $.post(`http://evidence/hasNearest`, [], (data) => {
            if (data.has) {
                $(".right span").html(`Verificando o(a) <b style="color: rgba(45, 228, 131, 0.8); font-weight: 300">${data.firstname}</b>...`)

                timeOuts.push(setTimeout(() => {
                    $("#initial").fadeOut();

                    $(".border-top").css("animation", "none")
                    $(".border-bottom").css("animation", "none")
                    $(".image img").css("animation", "none")


                    timeOuts.push(setTimeout(() => {
                        analysing = false;

                        let text = data.type === 'sucess' ? (tabletType === 'polvora' ? 'Nenhum resíduo de pólvora encontrado' : 'Nenhum resíduo químico encontrado') : (tabletType === 'polvora' ? 'Grande quantidade de resíduos de pólvora encontrados' : 'Grande quantidade de resíduos químicos encontrados')
                        let color = data.type === 'sucess' ? 'rgba(45, 228, 131, 0.8)' :  'rgb(217, 61, 76)'

                        $("#result").fadeIn(500);
                        $("#result p").css("color", color);
                        $("#result p").text(text);
                    }, 500));
                }, 5000));
            } else {
                timeOuts.push(setTimeout(() => {
                    $(".right span").text("Não há ninguém próximo a você...")

                    timeOuts.push(setTimeout(() => {
                        Close();
                    }, 2500));
                }, 5000));
            }
        })
    });

    $(document).on("click", "#exit", Close);

    function Close () {
        timeOuts.forEach(timeout => clearTimeout(timeout));
        timeOuts = [];

        $("#evidence").fadeOut(500);
        $("#initial").hide();
        $("#starting").hide();
        $("#result").hide();

        $(".border-top").css("animation", "none")
        $(".border-bottom").css("animation", "none")
        $(".image img").css("animation", "none")


        analysing = false;

        $.post(`http://evidence/close`, [])
    }
})