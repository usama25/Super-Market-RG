// DecompilerFi decompiler from Assembly-CSharp.dll class: SliderMods
using UnityEngine;
using UnityEngine.UI;
using Yelbouziani;
using Yelbouziani.Enum.Me;

public class SliderMods : MonoBehaviour
{
	[Header("Mode")]
	public Mode Manager;

	private void Start()
	{
		Init();
		GetComponent<Slider>().onValueChanged.AddListener(ValueMoved);
	}

	private void ValueMoved(float Value)
	{
		switch (Manager)
		{
		case Mode.LookSensX:
			PlayerPrefs.SetFloat(YelbRef.ValueLookX, Value);
			break;
		case Mode.LookSensY:
			PlayerPrefs.SetFloat(YelbRef.ValueLookY, Value);
			break;
		case Mode.Resolution:
			PlayerPrefs.SetFloat(YelbRef.ValueResolution, Value);
			QualitySettings.resolutionScalingFixedDPIFactor = 0.5f + Value;
			break;
		case Mode.CashierLook:
			PlayerPrefs.SetFloat(YelbRef.ValueCashier, Value);
			break;
		case Mode.ColorB:
			PlayerPrefs.SetFloat(YelbRef.ColorMode + "b", Value);
			break;
		case Mode.ColorR:
			PlayerPrefs.SetFloat(YelbRef.ColorMode + "r", Value);
			break;
		case Mode.ColorG:
			PlayerPrefs.SetFloat(YelbRef.ColorMode + "g", Value);
			break;
		}
	}

	public void Init()
	{
		switch (Manager)
		{
		case Mode.LookSensX:
			if (YelbBackend.GetValueFromFloat(YelbRef.ValueLookX) == 0f)
			{
				PlayerPrefs.SetFloat(YelbRef.ValueLookX, 0.5f);
			}
			GetComponent<Slider>().value = YelbBackend.GetValueFromFloat(YelbRef.ValueLookX);
			break;
		case Mode.LookSensY:
			if (YelbBackend.GetValueFromFloat(YelbRef.ValueLookY) == 0f)
			{
				PlayerPrefs.SetFloat(YelbRef.ValueLookY, 0.5f);
			}
			GetComponent<Slider>().value = YelbBackend.GetValueFromFloat(YelbRef.ValueLookY);
			break;
		case Mode.Resolution:
			if (YelbBackend.GetValueFromFloat(YelbRef.ValueResolution) == 0f)
			{
				PlayerPrefs.SetFloat(YelbRef.ValueResolution, 0.5f);
			}
			GetComponent<Slider>().value = YelbBackend.GetValueFromFloat(YelbRef.ValueResolution);
			break;
		case Mode.CashierLook:
			if (YelbBackend.GetValueFromFloat(YelbRef.ValueCashier) == 0f)
			{
				PlayerPrefs.SetFloat(YelbRef.ValueCashier, 0.5f);
			}
			GetComponent<Slider>().value = YelbBackend.GetValueFromFloat(YelbRef.ValueCashier);
			break;
		case Mode.ColorR:
			GetComponent<Slider>().value = YelbBackend.GetValueFromFloat(YelbRef.ColorMode + "r");
			break;
		case Mode.ColorG:
			GetComponent<Slider>().value = YelbBackend.GetValueFromFloat(YelbRef.ColorMode + "g");
			break;
		case Mode.ColorB:
			GetComponent<Slider>().value = YelbBackend.GetValueFromFloat(YelbRef.ColorMode + "b");
			break;
		}
	}
}
