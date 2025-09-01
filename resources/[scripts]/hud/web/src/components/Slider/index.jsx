import * as S from "./styles";

import { GoMute, GoUnmute } from "react-icons/go";

export function Slider({
  max,
  min,
  step = 1,
  middle = false,
  ruler = false,
  value,
  setValue,
  ...rest
}) {
  return (
    <S.Container ruler={ruler}>
      <S.Wrap>
        <GoMute />
        <S.FullSlider>
          <S.Root
            defaultValue={[value]}
            {...rest}
            max={max}
            min={min}
            step={step}
            onValueChange={(v) => {
              setValue(v[0]);
            }}
          >
            <S.Track>
              <S.Range />
            </S.Track>
            <S.Thumb />
          </S.Root>
          {ruler && (
            <S.Ruler>
              <S.Min>{min}</S.Min>
              {middle !== null && <S.Middle>{middle}</S.Middle>}
              <S.Max>{max}</S.Max>
            </S.Ruler>
          )}
        </S.FullSlider>
        <GoUnmute />
        <S.Display
          disabled
          type="number"
          max={max}
          min={max}
          step={step}
          value={value}
          onValueChange={(val) => setValue(val)}
        />
      </S.Wrap>
    </S.Container>
  );
}
