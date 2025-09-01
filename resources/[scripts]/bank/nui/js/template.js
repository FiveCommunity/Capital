// ------------------------------------------------------------------------
// --- [ Templates acesso rapido ]
// ------------------------------------------------------------------------
function template_depositar() {
  return `
        <div class="title">Depositar</div>
        <div class="modal-input">
            <label>${language.depositar.quantidade}</label>
            <input id="value" placeholder="EX: 500,000">
        </div>
        <button id="confirm" onclick="my_deposit(this)"><i class="far fa-check icon" ></i> ${language.depositar.confirmar}</button>
        <button id="cancelar" onclick="closeModal()"><i class="fas fa-times icon"></i> ${language.depositar.cancelar}</button>
        <div class="modal-warning">
            ${language.depositar.warning}
        </div>
    `;
}

function template_sacar() {
  return `
        <div class="title">Sacar</div>
        <div class="modal-input">
            <label>${language.sacar.quantidade}</label>
            <input id="value" placeholder="EX: 500,000">
        </div>
        <button id="confirm" onclick="withdrawal(this)"><i class="far fa-check icon" ></i>${language.sacar.confirmar}</button>
        <button id="cancelar" onclick="closeModal()"><i class="fas fa-times icon"></i>${language.sacar.cancelar}</button>
        <div class="modal-warning">
            ${language.sacar.warning}
        </div>
    `;
}

function template_transfer() {
  return `
        <div class="title">Transferir</div>
        <div class="modal-input">
            <label>PASSAPORTE</label>
            <input id="value" placeholder="EX: 1">
        </div>
        <button id="confirm" onclick="transfer(this)"><i class="far fa-check icon" ></i>${language.sacar.confirmar}</button>
        <button id="cancelar" onclick="closeModal()"><i class="fas fa-times icon"></i>${language.sacar.cancelar}</button>
        <div class="modal-warning">
            ${language.sacar.warning}
        </div>
    `;
}

function template_transfer2() {
  return `
        <div class="title">Transferir</div>
        <div class="modal-input">
            <label>${language.sacar.quantidade}</label>
            <input id="value" placeholder="EX: 500,000">
        </div>
        <button id="confirm" onclick="transfer2(this)"><i class="far fa-check icon" ></i>${language.sacar.confirmar}</button>
        <button id="cancelar" onclick="closeModal()"><i class="fas fa-times icon"></i>${language.sacar.cancelar}</button>
        <div class="modal-warning">
            ${language.sacar.warning}
        </div>
    `;
}

function template_create_pix() {
  return `
        <div class="title">${language.pix.text1}</div>
        <div class="modal-input">
            <label>${language.pix.text2}</label>
            <input id="value" placeholder="${language.pix.text3}">
        </div>
        <button id="confirm" onclick="register_pix()"><i class="far fa-check icon" ></i>${language.pix.confirmar}</button>
        <button id="cancelar" onclick="closeModal()"><i class="fas fa-times icon"></i>${language.pix.cancelar}</button>
        <div class="modal-warning">
            ${language.pix.warning}
        </div>
    `;
}

function template_edit_pix() {
  return `
        <div class="title">${language.editpix.text1}</div>
        <div class="modal-input">
            <label>${language.editpix.text2}</label>
            <input id="value" placeholder="${language.editpix.text3}">
        </div>
        <button id="confirm" onclick="edit_pix_post()"><i class="far fa-check icon" ></i>${language.editpix.confirmar}</button>
        <button id="cancelar" onclick="closeModal()"><i class="fas fa-times icon"></i>${language.editpix.cancelar}</button>
        <div class="modal-warning">
            ${language.editpix.warning}
        </div>
    `;
}

const pix_template = () => {
  return `
    <div class="pix-content flex">
        <div class="pix-item flex " onclick="create_pix()">
            <i class="fas fa-plus-square icon"></i>
            <span>${language.pixCreate.criar}</span>
        </div>
        <div class="pix-item flex" onclick="edit_pix()">
            <i class="far fa-exchange icon" ></i>
            <span>${language.pixCreate.editar}</span>
        </div>
        <div class="pix-item flex" onclick="remove_pix()">
            <i class="fas fa-trash-alt icon"></i>
            <span>${language.pixCreate.remover}</span>
        </div>
    </div>
    <div class="pix-key flex">${language.pixCreate.registro}</div>
    `;
};

// ------------------------------------------------------------------------
// --- [ Templates HTML ]
// ------------------------------------------------------------------------
function template_modal(id, nome) {
  return `
        <div class="title">Transferir</div>
        <div class="modal-input">
            <label>${language.transferir.passaporte}</label>
            <input id="target" placeholder="EX: 1">
        </div>
        <div class="modal-input">
            <label>${language.transferir.quantidade}</label>
            <input id="value" placeholder="EX: 500,000">
        </div>
        <button id="confirm" onclick="enviar_transferia(this)" data-id = "${id}"><i class="far fa-check icon" ></i> ${language.transferir.confirmar}</button>
        <button id="cancelar" onclick="closeModal()"><i class="fas fa-times icon"></i> ${language.transferir.cancelar}</button>
        <div class="modal-warning">
            ${language.transferir.warning}
        </div>
    `;
}

function template_history_trans(type, value) {
  return `
    <div class="extract-item" style="display: flex;">
        <div class="extract-icon flex">
           <div class="icon flex"><i class="fas fa-search-dollar"></i></div>
               <div class="text-icon">
                   <a>${type}</a>
                   <small></small>
               </div>
           </div>
        <span> ${value}</span>
    </div>
    `;
}

function template_item_multa(id, motivo, data, value, desc) {
  return `
    <label><label></label>
    <div class="item active-item multa-item" onclick="selectTraffic(this)" data-valor ="${value}" data-motivo= "${motivo}" data-dia="${data}"data-id="${id}"data-desc="${desc}">
        <div class="item-title flex-inline">
            <div class="item-photo flex">w</div>
            <small>${motivo}</small>
        </div>
        <div class="item-info">
            <p>${data}</p>
            <sub>#${id}</sub>
        </div>
        <div class="item-value">
            <h3>$${value}</h3>
        </div>
    </div>
    `;
}

function tamplate_notify_sucess(title, message) {
  return `
    <div class="svg">
        <svg class="checkmark success" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52"><circle class="checkmark_circle_success" cx="26" cy="26" r="25" fill="none"/><path class="checkmark_check" stroke-linecap="round" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8"/></svg>
    </div>
    <div class="line"></div>
    <div class="text">
        <span>${title}</span><br>
        <small>${message}</small>
    </div>
    `;
}

function tamplate_notify_error(title, message) {
  return `
    <div class="svg">
        <svg class="checkmark error" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52"><circle class="checkmark_circle_error" cx="26" cy="26" r="25" fill="none"/><path class="checkmark_check" stroke-linecap="round" fill="none" d="M16 16 36 36 M36 16 16 36"/></svg>
    </div>
    <div class="line"></div>
    <div class="text">
        <span>${title}</span><br>
        <small>${message}</small>
    </div>
    `;
}

function show_info_multa(motivo, id) {
  return `
    <div class="pay-title">
        <div class="left flex-inline">
            <div class="pay-photo flex">wr</div>
            <div class="pay-info">
                <h3>${motivo}</h3>
                <sub>#${id}</sub>
            </div>
        </div>
        <button onclick="pay_select_multa(this)" data-id="${id}">${language.multas.pagar}</button>
    </div>
    <div class="pay-card">
        <div class="pay-tabel wrap">
            <h1>${language.multas.detalhes}</h1>
            <!-- Informações -->
            <label>${language.multas.motivo}</label>
            <span id="typeTraffic">${language.multas.text1}</span>
            <label>${language.multas.valor}</label>
            <span>${language.multas.moeda} <span id="priceTraffic">${language.multas.text2}</span></span>
            <label>${language.multas.nmulta}</label>
            <span>#<span id="numberTraffic">${language.multas.nencontrado}</span></span>
            <label>${language.multas.data}</label>
            <span id="dateTraffic">${language.multas.nencontrado}</span>
            <label>${language.multas.descricao}</label>
            <span id="noteTraffic">${language.multas.nencontrado}</span>
        </div>
        <div class="pay-fiscal">
            <div class="flex-inline">
                <div class="photo"></div>
                <div class="bar" style="margin-top: -20px !important;"></div>
            </div>
            <div class="flex-between">
                <div class="bar">
                    <div class="bar"></div>
                    <div class="bar"></div>
                    <div class="bar"></div>
                </div>
                <div class="bar">
                    <div class="bar"></div>
                    <div class="bar"></div>
                    <div class="bar"></div>
                </div>
                <div class="bar">
                    <div class="bar"></div>
                    <div class="bar"></div>
                    <div class="bar"></div>
                </div>
            </div>
            <div class="bar-footer">
                <div class="bar">
                    <div class="bar"></div>
                    <div class="bar"></div>
                    <div class="bar"></div>
                </div>
            </div>
        </div>
    </div>
    `;
}

function template_rendimento(value) {
  return `
    <div class="item">
        <div class="icon flex">+</div>
        <span>${language.rendimento.moeda} ${value}</span>
        <small>${language.rendimento.text}<br> ${language.rendimento.text1}</small>
    </div>
    `;
}
