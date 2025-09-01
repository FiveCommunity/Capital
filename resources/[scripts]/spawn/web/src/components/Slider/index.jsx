import * as S from "./styles";

import { Label } from "../Label";

export function Slider({
  label,
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
      <Label label={label} />
      <S.Wrap>
        <S.Display
          disabled
          type="number"
          max={max}
          min={max}
          step={step}
          value={value}
          onValueChange={(val) => setValue(val)}
        />
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
      </S.Wrap>
    </S.Container>
  );
}
