// DecompilerFi decompiler from Assembly-CSharp.dll class: TriggerShelf
using UnityEngine;
using UnityEngine.UI;
using Yelbouziani;
using Yelbouziani.Enum;

public class TriggerShelf : MonoBehaviour
{
	[Header("Manager")]
	internal YelbShelf ShelfData;

	internal YelbController Controller;

	[Header("Transforms")]
	public Transform[] SlotsMenu;

	[Header("Objects")]
	public GameObject EraserShelf;

	public GameObject ToggleShelf;

	[Header("strings")]
	internal string TypeShelf = "null";

	internal string IconNameItem = "";

	[Header("Text")]
	public Text[] Prices;

	[Header("Integer Controller")]
	internal int TotalItems;

	private void Awake()
	{
		Controller = UnityEngine.Object.FindObjectOfType<YelbController>();
		ShelfData = base.transform.parent.GetComponent<YelbShelf>();
	}

	private void LateUpdate()
	{
	}

	public void UpdatePrice(float Value)
	{

	}

	public void LoadShelfData()
	{
		YelbController yelbController = UnityEngine.Object.FindObjectOfType<YelbController>();
		string iDIInformation = ShelfData.transform.GetComponent<YelbReference>().IDIInformation;
		if (!(iDIInformation != "") || string.IsNullOrEmpty(iDIInformation))
		{
			return;
		}
		for (int i = 0; i < SlotsMenu.Length; i++)
		{
			Transform transform = SlotsMenu[i].transform;
			string valueFromString = YelbBackend.GetValueFromString(IDInformation(iDIInformation) + transform.name + ShelfData.name);
			if (string.IsNullOrEmpty(valueFromString) || !(valueFromString != ""))
			{
				continue;
			}
			string[] array = valueFromString.Split('/');
			if (array.Length < 5)
			{
				continue;
			}
			string b = array[0];
			string b2 = array[1];
			string typeShelf = array[2];
			string a = array[3];
			string text = array[4];
			if (!(transform.name == b) || !(a == "active"))
			{
				continue;
			}
			TotalItems++;
			ShelfData.TotalItems++;
			Object.FindObjectOfType<YelbController>().TotalItems++;
			Text[] prices = Prices;
			for (int j = 0; j < prices.Length; j++)
			{
				prices[j].text = text;
			}
			for (int k = 0; k < yelbController.ComputerController.COMP.Length; k++)
			{
				ComputerButtons computerButtons = yelbController.ComputerController.COMP[k];
				for (int l = 0; l < computerButtons.Items.Length; l++)
				{
					ShopItem shopItem = computerButtons.Items[l];
					if (shopItem.ImageIcon.name == b2)
					{
						GameObject gameObject = UnityEngine.Object.Instantiate(shopItem.OBJ);
						gameObject.transform.SetParent(transform);
						gameObject.transform.localPosition = Vector3.zero;
						gameObject.transform.localEulerAngles = Vector3.zero;
						gameObject.transform.localScale = new Vector3(1.3f, 1.3f, 1.3f);
						ItemInfo itemInfo = gameObject.AddComponent<ItemInfo>();
						itemInfo.Priceitem = float.Parse(text, System.Globalization.CultureInfo.InvariantCulture);
						itemInfo.ItemName = shopItem.NameItem;
						itemInfo.IconItem = shopItem.ImageIcon;
						IconNameItem = shopItem.ImageIcon.name;
						TypeShelf = typeShelf;
					}
				}
			}
		}
	}

	public void TakeItem(Transform Slot)
	{
		bool flag = false;
		for (int i = 0; i < SlotsMenu.Length; i++)
		{
			if (SlotsMenu[i].childCount > 0)
			{
				flag = true;
			}
		}
		if (!flag)
		{
			TypeShelf = "null";
			IconNameItem = "";
			for (int j = 0; j < Prices.Length; j++)
			{
				Prices[j].text = "";
			}
		}
		string text = "null";
		string iDIInformation = ShelfData.transform.GetComponent<YelbReference>().IDIInformation;
		string information = Slot.name + "/" + IconNameItem + "/" + TypeShelf + "/" + text + "/" + Prices[0].text;
		YelbBackend.GetValueFromString(IDInformation(iDIInformation) + Slot.name + ShelfData.name);
		YelbBackend.SaveData(IDInformation(iDIInformation) + Slot.name + ShelfData.name, information, DataType.stringV);
		TotalItems--;
		ShelfData.TotalItems--;
		Controller.TotalItems--;
	}

	public void UpdateShelfData()
	{
		Transform[] slotsMenu = SlotsMenu;
		foreach (Transform transform in slotsMenu)
		{
			if (transform.transform.childCount > 0 && Prices[0].text != "")
			{
				transform.transform.GetChild(0).GetComponent<ItemInfo>().Priceitem = float.Parse(Prices[0].text, System.Globalization.CultureInfo.InvariantCulture);
			}
		}
		for (int j = 0; j < SlotsMenu.Length; j++)
		{
			Transform transform2 = SlotsMenu[j].transform;
			string text = "null";
			if (transform2.childCount > 0)
			{
				TotalItems++;
				ShelfData.TotalItems++;
				Object.FindObjectOfType<YelbController>().TotalItems++;
				text = "active";
			}
			string iDIInformation = ShelfData.transform.GetComponent<YelbReference>().IDIInformation;
			string information = transform2.name + "/" + IconNameItem + "/" + TypeShelf + "/" + text + "/" + Prices[0].text;
			YelbBackend.SaveData(IDInformation(iDIInformation) + transform2.name + ShelfData.name, information, DataType.stringV);
		}
	}

	public void SetActionToggle()
	{
		ShelfData.ActivateTrigger(this);
	}

	public void DisableToggle()
	{
		ToggleShelf.SetActive(value: false);
	}

	public string IDInformation(string ID)
	{
		string result = "null";
		string[] array = ID.Split('/');
		if (array.Length >= 5)
		{
			string text = array[0];
			string text2 = array[1];
			string text3 = array[2];
			int num = int.Parse(array[3]);
			int num2 = int.Parse(array[4]);
			return text + "/" + text2 + "/" + text3 + "/" + num.ToString() + "/" + num2.ToString();
		}
		return result;
	}
}
