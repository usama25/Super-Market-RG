// DecompilerFi decompiler from Assembly-CSharp.dll class: ComputerController
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine;
using UnityEngine.UI;
using Yelbouziani;

public class ComputerController : MonoBehaviour
{
	[CompilerGenerated]
	private sealed class _003C_003Ec__DisplayClass22_0
	{
		public InputField ValueShow;

		public ManagerSpawning ModeController;

		public GameObject SpawnItem;

		public ShopItem item;

		public Button BasketBtn;

		public ComputerController _003C_003E4__this;

		internal void _003CSpawnList_003Eb__0()
		{
			_003C_003E4__this._003CSpawnList_003Eg__TakeControllerMinse_007C22_5(ValueShow, ModeController, SpawnItem, item, BasketBtn);
		}

		internal void _003CSpawnList_003Eb__1()
		{
			_003C_003E4__this._003CSpawnList_003Eg__TakeControllerPlus_007C22_4(ValueShow, ModeController, SpawnItem, item, BasketBtn);
		}

		internal void _003CSpawnList_003Eb__2()
		{
			_003C_003E4__this._003CSpawnList_003Eg__TakeBasket_007C22_3(item, SpawnItem);
		}
	}

	[CompilerGenerated]
	private sealed class _003C_003Ec__DisplayClass22_1
	{
		public ShopItem Information;

		public GameObject Taker;

		public ComputerController _003C_003E4__this;

		internal void _003CSpawnList_003Eb__6()
		{
			_003C_003E4__this._003CSpawnList_003Eg__TakeBasket_007C22_7(Information, Taker);
		}
	}

	[CompilerGenerated]
	private sealed class _003C_003Ec__DisplayClass22_2
	{
		public ShopItem Information;

		public GameObject Taker;

		public ComputerController _003C_003E4__this;

		internal void _003CSpawnList_003Eb__8()
		{
			_003C_003E4__this._003CSpawnList_003Eg__TakeBasket_007C22_9(Information, Taker);
		}
	}

	[Header("Objects")]
	public GameObject PanelShop;

	public GameObject PanelCustomize;

	public GameObject PanelBasket;

	public GameObject ClearBasket;

	public GameObject OrderBtn;

	public GameObject BasketSall;

	public GameObject LockPanel;

	public GameObject RewardHelper;

	[Header("SP")]
	public Sprite LockLevel;

	[Header("List Mods")]
	public ComputerButtons[] COMP;

	[Header("List Controller")]
	internal List<ManagerSpawning> ModesData = new List<ManagerSpawning>();

	internal List<string> OriginalNames = new List<string>();

	[Header("Text")]
	public Text PriceCash;

	public Text TotalItems;

	public Text TotalPrice;

	[Header("Int")]
	internal float TotalPricePaid;

	private void OnEnable()
	{
		for (int i = 0; i < COMP.Length; i++)
		{
			OriginalNames.Add(COMP[i].transform.parent.gameObject.name);
		}
		for (int j = 0; j < COMP.Length; j++)
		{
			COMP[j].TakeController();
		}
		COMP[0].GetComponent<Button>().onClick.Invoke();
		if (YelbBackend.GetValueFromFloat(base.name) != 0f)
		{
			RewardHelper.SetActive(value: true);
		}
		else
		{
			PlayerPrefs.SetFloat(base.name, 1f);
		}


	}

    private void OnDisable()
    {

	}
	private void LateUpdate()
	{
		PriceCash.text = "Shop Balance: $" + YelbBackend.GetValueFromFloat(YelbRef.CashValue).ToString("F2");
	}

	public void AddItemToBasket(ManagerSpawning MD)
	{
		if (ModesData.Count < 5)
		{
			TotalPricePaid += MD.PriceValue * (float)MD.ItemsToSpawn;
			BasketSall.SetActive(value: false);
			GameObject gameObject = UnityEngine.Object.Instantiate(BasketSall);
			gameObject.transform.SetParent(BasketSall.transform.parent);
			gameObject.transform.localScale = BasketSall.transform.localScale;
			gameObject.transform.GetChild(0).GetComponent<Text>().text = MD.NameItem + " x" + MD.ItemsToSpawn.ToString();
			gameObject.transform.GetChild(2).GetComponent<Text>().text = (MD.PriceValue * (float)MD.ItemsToSpawn).ToString() + "$";
			int num = YelbBackend.ExtractNumberFromString(TotalItems.text);
			TotalItems.text = (num + 1).ToString();
			ClearBasket.SetActive(value: true);
			OrderBtn.SetActive(value: true);
			TotalPrice.text = TotalPricePaid.ToString() + "<color=#14EE00>$</color>";
			gameObject.SetActive(value: true);
			ModesData.Add(MD);
		}
		else
		{
			List<string> information = new List<string>
			{
				"MAX ORDER 5 ITEMS"
			};
			Object.FindObjectOfType<YelbController>().SpawnNotification(information, null);
		}
	}

	public void ClearAllBasket()
	{
		ModesData.Clear();
		ClearBasket.SetActive(value: false);
		OrderBtn.SetActive(value: false);
		for (int i = 1; i < BasketSall.transform.parent.childCount; i++)
		{
			UnityEngine.Object.Destroy(BasketSall.transform.parent.GetChild(i).gameObject);
		}
		TotalPricePaid = 0f;
		TotalPrice.text = 0.ToString() + "<color=#14EE00>$</color>";
		TotalItems.text = "0";
	}



	bool adsWatched;
	public void GetRewardValue()
	{

		//if (AdsManager.instance)
			//AdsManager.instance.Show_AdMob_Rewarded();

		Debug.Log("ADS WATCHED");
		float valueFromFloat = YelbBackend.GetValueFromFloat(YelbRef.CashValue);
		float num = 200f;
		PlayerPrefs.SetFloat(YelbRef.CashValue, valueFromFloat + num);
	}

	

	void CompleteMethod()
    {
		adsWatched = true;
	}

	public void OrderBasket()
	{
		float valueFromFloat = YelbBackend.GetValueFromFloat(YelbRef.CashValue);
		float totalPricePaid = TotalPricePaid;
		if (valueFromFloat >= TotalPricePaid)
		{
			List<string> list = new List<string>();
			for (int i = 0; i < ModesData.Count; i++)
			{
				list.Add(ModesData[i].NameItem);
			}
			Object.FindObjectOfType<YelbController>().SpawnNotification(list, ModesData);
			ClearAllBasket();
			PlayerPrefs.SetFloat(YelbRef.CashValue, valueFromFloat - totalPricePaid);
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

	public void SpawnList(Transform Parent, Transform Content, GameObject SpawnOBJ, ShopItem[] Items, ComputerButtons Holder)
	{
		for (int i = 0; i < COMP.Length; i++)
		{
			COMP[i].ScroolView.GetComponent<ScrollRect>().verticalScrollbar.value = 1f;
			COMP[i].ScroolView.gameObject.SetActive(value: false);
		}
		if (!Holder.transform.parent.name.Contains("+"))
		{
			foreach (ShopItem item in Items)
			{
				GameObject SpawnItem = UnityEngine.Object.Instantiate(SpawnOBJ);
				SpawnItem.transform.parent = Content;
				SpawnItem.transform.localScale = SpawnOBJ.transform.localScale;
				ManagerSpawning ModeController = SpawnItem.AddComponent<ManagerSpawning>();
				ModeController.ModelYelb = item.OBJ;
				SpawnItem.transform.Find("ItemName").GetComponent<Text>().text = item.NameItem;
				SpawnItem.transform.Find("ItemDescription").GetComponent<Text>().text = item.DescriptionItem;
				SpawnItem.transform.Find("Price").GetComponent<Text>().text = item.PriceItem.ToString() + "$";
				SpawnItem.transform.Find("ItemImage").GetComponent<Image>().sprite = item.ImageIcon;
				SpawnItem.transform.Find("ItemImage").GetComponent<Image>().SetNativeSize();
				SpawnItem.transform.Find("ItemImage").transform.localScale = new Vector3(0.4f, 0.4f, 0.4f);
				GameObject gameObject = SpawnItem.transform.Find("Adding").gameObject;
				GameObject gameObject2 = UnityEngine.Object.Instantiate(LockPanel);
				gameObject2.transform.SetParent(SpawnItem.transform);
				gameObject2.name = LockPanel.name;
				gameObject2.SetActive(value: false);
				Button component = gameObject.transform.Find("-").GetComponent<Button>();
				Button component2 = gameObject.transform.Find("+").GetComponent<Button>();
				Button BasketBtn = gameObject.transform.GetChild(2).GetComponent<Button>();
				InputField ValueShow = gameObject.GetComponentInChildren<InputField>();
				if (item.AddToBasket)
				{
					gameObject.SetActive(value: true);
					component.gameObject.SetActive(value: false);
					component2.gameObject.SetActive(value: false);
					ValueShow.gameObject.SetActive(value: false);
					BasketBtn.gameObject.SetActive(value: true);
					BasketBtn.transform.localPosition = new Vector2(BasketBtn.transform.localPosition.x, -260f);
				}
				component.onClick.AddListener(delegate
				{
					_003CSpawnList_003Eg__TakeControllerMinse_007C22_5(ValueShow, ModeController, SpawnItem, item, BasketBtn);
				});
				component2.onClick.AddListener(delegate
				{
					_003CSpawnList_003Eg__TakeControllerPlus_007C22_4(ValueShow, ModeController, SpawnItem, item, BasketBtn);
				});
				BasketBtn.onClick.AddListener(delegate
				{
					_003CSpawnList_003Eg__TakeBasket_007C22_3(item, SpawnItem);
				});
				if (SpawnItem.transform.Find("LevelLock") != null)
				{
					gameObject2 = SpawnItem.transform.Find("LevelLock").gameObject;
					if (YelbBackend.GetValueFromFloat(YelbRef.StoreLevel) + 1f < (float)item.Level)
					{
						gameObject2.SetActive(value: true);
						component.gameObject.SetActive(value: false);
						component2.gameObject.SetActive(value: false);
						BasketBtn.gameObject.SetActive(value: false);
						ValueShow.gameObject.SetActive(value: false);
						gameObject2.GetComponentInChildren<Text>().text = "LEVEL " + item.Level.ToString();
						gameObject2.transform.localScale = new Vector3(1.03f, 1.02f, 1f);
						gameObject2.transform.localPosition = Vector3.zero;
						SpawnItem.GetComponent<Image>().sprite = LockLevel;
					}
				}
				SpawnItem.SetActive(value: true);
			}
			Holder.transform.parent.name += "+";
		}
		Parent.gameObject.SetActive(value: true);
	}

	public void OpenBasket()
	{
		PanelBasket.SetActive(!PanelBasket.activeSelf);
	}

	public void OpenShop(bool Mode)
	{
		PanelShop.SetActive(Mode);
		if (Mode)
		{
			return;
		}
		ClearAllBasket();
		ModesData.Clear();
		for (int i = 0; i < COMP.Length; i++)
		{
			COMP[i].transform.parent.gameObject.name = OriginalNames[i];
		}
		for (int j = 0; j < COMP.Length; j++)
		{
			if (COMP[j].ContentContainer != null)
			{
				for (int k = 1; k < COMP[j].ContentContainer.childCount; k++)
				{
					UnityEngine.Object.Destroy(COMP[j].ContentContainer.GetChild(k).gameObject);
				}
			}
			COMP[j].ScroolView.GetComponent<ScrollRect>().verticalScrollbar.value = 1f;
			COMP[j].ScroolView.gameObject.SetActive(value: false);
		}
		PanelBasket.SetActive(value: false);
	}

	public void OpenCustomize(bool Mode)
	{
		PanelCustomize.SetActive(Mode);
	}

	[CompilerGenerated]
	private void _003CSpawnList_003Eg__TakeBasket_007C22_3(ShopItem Information, GameObject Taker)
	{
		AddItemToBasket(new ManagerSpawning
		{
			ItemsToSpawn = 1,
			PriceValue = Information.PriceItem,
			ModelYelb = Information.OBJ,
			NameItem = Information.NameItem,
			IsBigBox = Information.IsBigBox,
			ShouldPlaceInside = Information.ShouldPlaceInside,
			IconItem = Information.ImageIcon
		});
	}

	[CompilerGenerated]
	private void _003CSpawnList_003Eg__TakeControllerPlus_007C22_4(InputField f, ManagerSpawning Mode, GameObject Taker, ShopItem Information, Button Basket)
	{
		int num = YelbBackend.ExtractNumberFromString(f.text);
		if (num < 12)
		{
			num++;
		}
		f.text = num.ToString();
		if (num == 0)
		{
			Basket.gameObject.SetActive(value: false);
			return;
		}
		if (Taker.GetComponent<ManagerSpawning>() == null)
		{
			Mode = Taker.AddComponent<ManagerSpawning>();
		}
		Taker.GetComponent<ManagerSpawning>().ItemsToSpawn = num;
		Taker.GetComponent<ManagerSpawning>().ModelYelb = Information.OBJ;
		Taker.GetComponent<ManagerSpawning>().PriceValue = Information.PriceItem;
		Taker.GetComponent<ManagerSpawning>().NameItem = Information.NameItem;
		Taker.GetComponent<ManagerSpawning>().IsBigBox = Information.IsBigBox;
		Taker.GetComponent<ManagerSpawning>().ShouldPlaceInside = Information.ShouldPlaceInside;
		Taker.GetComponent<ManagerSpawning>().IconItem = Information.ImageIcon;
		if (!Information.AddToBasket)
		{
			Basket.gameObject.SetActive(value: true);
			Basket.onClick.RemoveAllListeners();
			Basket.onClick.AddListener(delegate
			{
				_003CSpawnList_003Eg__TakeBasket_007C22_7(Information, Taker);
			});
		}
	}

	[CompilerGenerated]
	private void _003CSpawnList_003Eg__TakeBasket_007C22_7(ShopItem Data, GameObject Info)
	{
		Info.GetComponent<ManagerSpawning>().NameItem = Data.NameItem;
		AddItemToBasket(new ManagerSpawning
		{
			PriceValue = Info.GetComponent<ManagerSpawning>().PriceValue,
			ItemsToSpawn = Info.GetComponent<ManagerSpawning>().ItemsToSpawn,
			ModelYelb = Info.GetComponent<ManagerSpawning>().ModelYelb,
			NameItem = Info.GetComponent<ManagerSpawning>().NameItem,
			IsBigBox = Info.GetComponent<ManagerSpawning>().IsBigBox,
			ShouldPlaceInside = Info.GetComponent<ManagerSpawning>().ShouldPlaceInside,
			IconItem = Info.GetComponent<ManagerSpawning>().IconItem
		});
	}

	[CompilerGenerated]
	private void _003CSpawnList_003Eg__TakeControllerMinse_007C22_5(InputField f, ManagerSpawning Mode, GameObject Taker, ShopItem Information, Button Basket)
	{
		int num = YelbBackend.ExtractNumberFromString(f.text);
		if (num >= 1)
		{
			num--;
		}
		f.text = num.ToString();
		if (num == 0)
		{
			Basket.gameObject.SetActive(value: false);
			return;
		}
		if (Taker.GetComponent<ManagerSpawning>() == null)
		{
			Mode = Taker.AddComponent<ManagerSpawning>();
		}
		Taker.GetComponent<ManagerSpawning>().ItemsToSpawn = num;
		Taker.GetComponent<ManagerSpawning>().ModelYelb = Information.OBJ;
		Taker.GetComponent<ManagerSpawning>().PriceValue = Information.PriceItem;
		Taker.GetComponent<ManagerSpawning>().NameItem = Information.NameItem;
		Taker.GetComponent<ManagerSpawning>().IsBigBox = Information.IsBigBox;
		Taker.GetComponent<ManagerSpawning>().ShouldPlaceInside = Information.ShouldPlaceInside;
		Taker.GetComponent<ManagerSpawning>().IconItem = Information.ImageIcon;
		if (!Information.AddToBasket)
		{
			Basket.gameObject.SetActive(value: true);
			Basket.onClick.RemoveAllListeners();
			Basket.onClick.AddListener(delegate
			{
				_003CSpawnList_003Eg__TakeBasket_007C22_9(Information, Taker);
			});
		}
	}

	[CompilerGenerated]
	private void _003CSpawnList_003Eg__TakeBasket_007C22_9(ShopItem Data, GameObject Info)
	{
		Info.GetComponent<ManagerSpawning>().NameItem = Data.NameItem;
		AddItemToBasket(new ManagerSpawning
		{
			PriceValue = Info.GetComponent<ManagerSpawning>().PriceValue,
			ItemsToSpawn = Info.GetComponent<ManagerSpawning>().ItemsToSpawn,
			ModelYelb = Info.GetComponent<ManagerSpawning>().ModelYelb,
			NameItem = Info.GetComponent<ManagerSpawning>().NameItem,
			IsBigBox = Info.GetComponent<ManagerSpawning>().IsBigBox,
			ShouldPlaceInside = Info.GetComponent<ManagerSpawning>().ShouldPlaceInside,
			IconItem = Info.GetComponent<ManagerSpawning>().IconItem
		});
	}
}
