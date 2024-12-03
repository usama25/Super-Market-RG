// DecompilerFi decompiler from Assembly-CSharp.dll class: LoginPanel
using UnityEngine;
using UnityEngine.UI;
using Yelbouziani;
using Yelbouziani.Enum;

public class LoginPanel : MonoBehaviour
{
	public Button BtnVerifie;

	public InputField fieldValue;

	[Header("Boolean Manager")]
	internal bool BlockPip;

	private void Awake()
	{
		BtnVerifie = GetComponentInChildren<Button>(includeInactive: true);
		fieldValue = GetComponentInChildren<InputField>();
		string valueFromString = YelbBackend.GetValueFromString(YelbRef.NameStore);
		if (valueFromString != "")
		{
			fieldValue.text = valueFromString;
		}
		if (BtnVerifie != null)
		{
			BtnVerifie.onClick.AddListener(NextTutorial);
		}
	}

	private void LateUpdate()
	{
		if (!string.IsNullOrEmpty(fieldValue.text))
		{
			BtnVerifie.gameObject.SetActive(value: true);
		}
		else
		{
			BtnVerifie.gameObject.SetActive(value: false);
		}
	}

	private void NextTutorial()
	{
		YelbBackend.SaveData(YelbRef.NameStore, fieldValue.text, DataType.stringV);
		Object.FindObjectOfType<BooleanManager>().IsStoreStart = true;
		Object.FindObjectOfType<YelbController>().NameStore.text = fieldValue.text;
		if (!Object.FindObjectOfType<YelbController>().BlockTutorial)
		{
			Object.FindObjectOfType<YelbUI>().SetTutorialFirstTime(Mode: true);
		}
	}
}
