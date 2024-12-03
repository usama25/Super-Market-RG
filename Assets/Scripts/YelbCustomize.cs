// DecompilerFi decompiler from Assembly-CSharp.dll class: YelbCustomize
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Yelbouziani;
using Yelbouziani.Enum;

public class YelbCustomize : MonoBehaviour
{
	[Header("Manager")]
	public ComputerController ComputerController;

	[Header("Int")]
	public int LevelTarget = 1;

	public int Price;

	[Header("OBJ")]
	public GameObject BtnShop;

	public GameObject BtnDone;

	public GameObject CustomizePage;

	public GameObject PlayerContainer;

	[Header("Boolean Manager")]
	public bool IsColorize;

	public bool ExpandOne;

	public bool ExpandTwo;

	private void Start()
	{
		if (!(YelbBackend.GetValueFromFloat(YelbRef.StoreLevel) + 1f < (float)LevelTarget))
		{
			if (Price > 0)
			{
				BtnShop.SetActive(value: true);
				BtnDone.SetActive(value: false);
				BtnShop.GetComponent<Button>().onClick.AddListener(TakeActionShop);
				BtnDone.GetComponent<Button>().onClick.AddListener(TakeAction);
			}
			else
			{
				BtnShop.SetActive(value: false);
				BtnDone.SetActive(value: true);
				BtnShop.GetComponent<Button>().onClick.AddListener(TakeActionShop);
				BtnDone.GetComponent<Button>().onClick.AddListener(TakeAction);
				if (ExpandOne && YelbBackend.GetValueFromString(YelbRef.ExpandBoxOne) == "done")
				{
					BtnDone.SetActive(value: false);
				}
				if (ExpandTwo && YelbBackend.GetValueFromString(YelbRef.ExpandBoxTwo) == "done")
				{
					BtnDone.SetActive(value: false);
				}
			}
		}
		if (YelbBackend.GetValueFromString(base.name) != "")
		{
			BtnShop.SetActive(value: false);
			BtnDone.SetActive(value: true);
		}
	}

	public void TakeActionShop()
	{
		float valueFromFloat = YelbBackend.GetValueFromFloat(YelbRef.CashValue);
		if (valueFromFloat >= (float)Price)
		{
			YelbBackend.SaveData(base.name, "done", DataType.stringV);
			BtnShop.SetActive(value: false);
			BtnDone.SetActive(value: true);
			YelbBackend.SaveData(YelbRef.CashValue, (valueFromFloat - (float)Price).ToString(), DataType.floatV);
		}
		else
		{
			List<string> information = new List<string>
			{
				"NO ENOUGH MONEY"
			};
			Object.FindObjectOfType<YelbController>().SpawnNotification(information, null);
		}
	}

	public void TakeAction()
	{
		if (IsColorize)
		{
			Object.FindObjectOfType<YelbController>().UIController.PanelColorize.SetActive(value: true);
			ComputerController.gameObject.SetActive(value: false);
			PlayerContainer.gameObject.SetActive(value: false);
			CustomizePage.gameObject.SetActive(value: false);
		}
		if (ExpandOne)
		{
			YelbBackend.SaveData(YelbRef.ExpandBoxOne, "done", DataType.stringV);
			Object.FindObjectOfType<YelbController>().UpdateBoxsRoom();
			BtnDone.SetActive(value: false);
		}
		if (ExpandTwo)
		{
			YelbBackend.SaveData(YelbRef.ExpandBoxTwo, "done", DataType.stringV);
			Object.FindObjectOfType<YelbController>().UpdateBoxsRoom();
			BtnDone.SetActive(value: false);
		}
	}
}
