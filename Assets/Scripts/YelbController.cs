// DecompilerFi decompiler from Assembly-CSharp.dll class: YelbController
using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine;
using UnityEngine.UI;
using Yelbouziani;
using Yelbouziani.Enum;

public class YelbController : MonoBehaviour
{
	[Header("Manager")]
	internal YelbUI UIController;

	internal Yelbdata DATAController;

	internal YelbLinker LinkerController;

	internal YelbTransform TransformController;

	internal YelbMods ModsController;

	internal YelbCharacter CharacterController;

	internal YelbCustomColor ColorManagement;

	internal ComputerController ComputerController;

	[Header("Text")]
	public Text NameStore;

	public Text CashValue;

	public Text StoreLevel;

	[Header("Image")]
	public Image LevelValueFill;

	[Header("Objects")]
	public GameObject NotificationPref;

	public GameObject BoxOne;

	public GameObject BoxTwo;

	[Header("Outline")]
	public GameObject[] OutlineCOMPO;

	[Header("Colors")]
	public Color NormalColor;

	public Color WrongColor;

	[Header("Boolean Manager")]
	internal bool BlockTutorial;

	internal bool IsStartGame;

	internal bool IsEmptyShop = true;

	[Header("Integer")]
	internal int TotalItems;

	[Header("Floating")]
	internal float UpdatedItems = 200f;

	private void Awake()
	{
		if (YelbBackend.GetValueFromString("YelbLauncher") == "")
		{
			YelbBackend.SaveData(YelbRef.CashValue, "150", DataType.floatV);
			YelbBackend.SaveData(YelbRef.StoreLevel, "1", DataType.floatV);
			LevelValueFill.fillAmount = 0f;
		}
		LevelInformations();
	}

	public bool soundIsOn = true;
	public void enableDisableSound()
    {
        if (soundIsOn)
        {
			GameObject.Find("BG").GetComponent<AudioSource>().Pause();
			AudioListener.volume = 0;
			soundIsOn = false;
        }
        else
        {
			AudioListener.volume = 1;
			GameObject.Find("BG").GetComponent<AudioSource>().volume = 0.2f;
			GameObject.Find("BG").GetComponent<AudioSource>().Play();
			soundIsOn = true;
		}
    }
	private void Start()
	{
		Init();
		if (YelbBackend.GetValueFromString("YelbLauncher") == "")
		{
			UIController.PanelLoginName.SetActive(value: true);
			UIController.PanelLoginName.gameObject.AddComponent<LoginPanel>();
			YelbBackend.SaveData(YelbRef.ColorMode + "r", "1", DataType.floatV);
			YelbBackend.SaveData(YelbRef.ColorMode + "g", "0", DataType.floatV);
			YelbBackend.SaveData(YelbRef.ColorMode + "b", "0", DataType.floatV);
			YelbBackend.SaveData(YelbRef.ColorMode + "a", "1", DataType.floatV);
			SliderMods[] array = UnityEngine.Object.FindObjectsOfType<SliderMods>(includeInactive: true);
			for (int i = 0; i < array.Length; i++)
			{
				array[i].Init();
			}
			//YelbBackend.SaveData("YelbMusic", "on", DataType.stringV);
			YelbBackend.SaveData("YelbLauncher", "done", DataType.stringV);
		}
		else
		{
			IsStartGame = true;
		}
		UpdateBoxsRoom();
		LoadAllData();
		InitColor();
		QualitySettings.resolutionScalingFixedDPIFactor = 0.5f + YelbBackend.GetValueFromFloat(YelbRef.ValueResolution);
	}

	private void Update()
	{
	}

	private void LateUpdate()
	{
		if (TotalItems > 0)
		{
			IsEmptyShop = false;
		}
		else
		{
			IsEmptyShop = true;
		}
		CashValue.text = YelbBackend.GetValueFromFloat(YelbRef.CashValue).ToString("F2") + "$";
	}

	private void Init()
	{
		UIController = GetComponent<YelbUI>();
		DATAController = GetComponent<Yelbdata>();
		LinkerController = GetComponent<YelbLinker>();
		TransformController = GetComponent<YelbTransform>();
		ModsController = GetComponent<YelbMods>();
		ColorManagement = UnityEngine.Object.FindObjectOfType<YelbCustomColor>(includeInactive: true);
		ComputerController = UnityEngine.Object.FindObjectOfType<ComputerController>(includeInactive: true);
		CharacterController = UnityEngine.Object.FindObjectOfType<YelbCharacter>();
		LinkerController.TurnOff.onClick.AddListener(delegate
		{
			UIController.PanelComputer.SetActive(value: false);
		});
		LinkerController.SettingBtn.onClick.AddListener(delegate
		{
			UIController.PanelSettings.SetActive(value: true);
		});
		LinkerController.TutorialBtn.onClick.AddListener(delegate
		{
			UIController.SetTutorialFirstTime(Mode: false);
		});
		LinkerController.EmptyHand.onClick.AddListener(delegate
		{
			CharacterController.SetEraser(Status: false);
		});
		LinkerController.ActiveEraser.onClick.AddListener(delegate
		{
			CharacterController.SetEraser(Status: true);
		});
		LinkerController.SoundBtn.onClick.AddListener(delegate
		{
			//SetMusicMode();
		});
		if (YelbBackend.GetValueFromString("YelbMusic") == "off")
		{
			base.transform.GetChild(0).GetComponent<AudioSource>().volume = 0f;
		}
		NameStore.text = (YelbBackend.GetValueFromString(YelbRef.NameStore) ?? "");
	}

	public void LevelInformations()
	{
		float valueFromFloat = YelbBackend.GetValueFromFloat(YelbRef.LevelPickedValue);
		float fillAmount = valueFromFloat / UpdatedItems;
		LevelValueFill.fillAmount = fillAmount;
		if (valueFromFloat >= 1f)
		{
			GameObject.Find("WinsoundNextLevel").GetComponent<AudioSource>().Play();
			PlayerPrefs.SetFloat(YelbRef.StoreLevel, YelbBackend.GetValueFromFloat(YelbRef.StoreLevel) + 1f);
			StoreLevel.text = "STORE LEVEL " + YelbBackend.GetValueFromFloat(YelbRef.StoreLevel).ToString();
			PlayerPrefs.SetFloat(YelbRef.LevelPickedValue, 0f);
		}
		else
		{
			StoreLevel.text = "STORE LEVEL " + YelbBackend.GetValueFromFloat(YelbRef.StoreLevel).ToString();
		}
	}

	private void InitColor()
	{
		float valueFromFloat = YelbBackend.GetValueFromFloat(YelbRef.ColorMode + "r");
		float valueFromFloat2 = YelbBackend.GetValueFromFloat(YelbRef.ColorMode + "g");
		float valueFromFloat3 = YelbBackend.GetValueFromFloat(YelbRef.ColorMode + "b");
		MeshRenderer[] renders = ColorManagement.Renders;
		foreach (MeshRenderer meshRenderer in renders)
		{
			if (meshRenderer.materials.Length > 1)
			{
				meshRenderer.materials[1].SetColor("_Color", new Color(valueFromFloat, valueFromFloat2, valueFromFloat3, 1f));
				meshRenderer.materials[1].color = new Color(valueFromFloat, valueFromFloat2, valueFromFloat3, 1f);
			}
			else
			{
				meshRenderer.material.SetColor("_Color", new Color(valueFromFloat, valueFromFloat2, valueFromFloat3, 1f));
				meshRenderer.material.color = new Color(valueFromFloat, valueFromFloat2, valueFromFloat3, 1f);
			}
		}
	}

	public void SetSmoothTransform(List<Transform> Items, List<Transform> Solts, YelbBox Box, TriggerShelf Shelf)
	{
		int num = 0;
		for (int i = 0; i < Items.Count; i++)
		{
			if (i < Solts.Count)
			{
				num++;
			}
		}
		if (num > 0)
		{
			UpdateDataObject(Box.IDInformation, num, Box);
		}
		Shelf.TypeShelf = Box.ItemName;
		Shelf.IconNameItem = Box.IconItem.name;
		StartCoroutine(LoadingPosition(Items, Solts, num, Box, Shelf));
	}

	public void RemoveObject(string ID)
	{
		string[] array = YelbBackend.GetValueFromString(YelbRef.ContainerGamePlay).Split(new char[2]
		{
			'\r',
			'\n'
		}, StringSplitOptions.RemoveEmptyEntries);
		if (array.Length == 0)
		{
			return;
		}
		List<string> list = new List<string>();
		for (int i = 0; i < array.Length; i++)
		{
			list.Add(array[i]);
		}
		string text = "";
		string text2 = "";
		string text3 = "";
		int num = 0;
		int num2 = 0;
		if (string.IsNullOrEmpty(ID))
		{
			return;
		}
		string[] array2 = ID.Split('/');
		if (array2.Length >= 7)
		{
			text = array2[0];
			text2 = array2[1];
			text3 = array2[2];
			num = int.Parse(array2[3]);
			num2 = int.Parse(array2[4]);
		}
		if (string.IsNullOrEmpty(text))
		{
			return;
		}
		foreach (string text4 in array)
		{
			string value = text + "/" + text2 + "/" + text3 + "/" + num.ToString() + "/" + num2.ToString();
			if (text4.Contains(value))
			{
				list.Remove(text4);
			}
		}
		string information = string.Join("\n", list);
		YelbBackend.SaveData(YelbRef.ContainerGamePlay, information, DataType.stringV);
	}

	public void UpdateDataObject(string ID, int Removed, YelbBox Box)
	{
		string[] array = YelbBackend.GetValueFromString(YelbRef.ContainerGamePlay).Split(new char[2]
		{
			'\r',
			'\n'
		}, StringSplitOptions.RemoveEmptyEntries);
		if (array.Length == 0)
		{
			return;
		}
		List<string> list = new List<string>();
		string text = "";
		string text2 = "";
		string text3 = "";
		int num = 0;
		int num2 = 0;
		Vector3 vector = Vector3.zero;
		Vector3 vector2 = Vector3.zero;
		if (string.IsNullOrEmpty(ID))
		{
			return;
		}
		string[] array2 = ID.Split('/');
		if (array2.Length >= 7)
		{
			text = array2[0];
			text2 = array2[1];
			text3 = array2[2];
			num = int.Parse(array2[3]);
			num2 = int.Parse(array2[4]);
			vector = YelbBackend.StringToVector3(array2[5]);
			vector2 = YelbBackend.StringToVector3(array2[6]);
		}
		if (string.IsNullOrEmpty(text))
		{
			return;
		}
		bool flag = false;
		for (int i = 0; i < array.Length; i++)
		{
			int countItems = num2 - Removed;
			string[] obj = new string[13]
			{
				text,
				"/",
				text2,
				"/",
				text3,
				"/",
				num.ToString(),
				"/",
				countItems.ToString(),
				"/",
				null,
				null,
				null
			};
			Vector3 vector3 = vector;
			obj[10] = vector3.ToString();
			obj[11] = "/";
			vector3 = vector2;
			obj[12] = vector3.ToString();
			string text4 = string.Concat(obj);
			string[] array3 = array[i].Split('/');
			if (array3.Length >= 7)
			{
				string a = array3[0];
				string a2 = array3[1];
				string a3 = array3[2];
				int num3 = int.Parse(array3[3]);
				int num4 = int.Parse(array3[4]);
				if (a == text && a2 == text2 && a3 == text3 && num3 == num && num4 == num2)
				{
					Box.CountItems = countItems;
					array[i] = text4;
					flag = true;
					break;
				}
			}
		}
		if (flag)
		{
			for (int j = 0; j < array.Length; j++)
			{
				list.Add(array[j]);
			}
			string information = string.Join("\n", list);
			YelbBackend.SaveData(YelbRef.ContainerGamePlay, information, DataType.stringV);
		}
	}

	public void AddDataObject(string ID)
	{
		string[] array = YelbBackend.GetValueFromString(YelbRef.ContainerGamePlay).Split(new char[2]
		{
			'\r',
			'\n'
		}, StringSplitOptions.RemoveEmptyEntries);
		if (array.Length != 0)
		{
			List<string> list = new List<string>();
			for (int i = 0; i < array.Length; i++)
			{
				list.Add(array[i]);
			}
			string text = "";
			string text2 = "";
			string text3 = "";
			int num = 0;
			int num2 = 0;
			if (string.IsNullOrEmpty(ID))
			{
				return;
			}
			string[] array2 = ID.Split('/');
			if (array2.Length >= 7)
			{
				text = array2[0];
				text2 = array2[1];
				text3 = array2[2];
				num = int.Parse(array2[3]);
				num2 = int.Parse(array2[4]);
			}
			if (string.IsNullOrEmpty(text))
			{
				return;
			}
			bool flag = false;
			foreach (string text4 in array)
			{
				string value = text + "/" + text2 + "/" + text3 + "/" + num.ToString() + "/" + num2.ToString();
				if (text4.Contains(value))
				{
					flag = true;
				}
			}
			if (!flag)
			{
				list.Add(ID);
			}
			string information = string.Join("\n", list);
			YelbBackend.SaveData(YelbRef.ContainerGamePlay, information, DataType.stringV);
		}
		else
		{
			YelbBackend.SaveData(YelbRef.ContainerGamePlay, ID, DataType.stringV);
		}
	}

	public void SaveDataObject(GameObject ModelObject, string NameIcon, string ItemTitle, int TotalItems, string IDInstance, Vector3 NewPos, Vector3 NewRot, bool STMode)
	{
		List<string> list = new List<string>();
		string[] array = YelbBackend.GetValueFromString(YelbRef.ContainerGamePlay).Split(new char[2]
		{
			'\r',
			'\n'
		}, StringSplitOptions.RemoveEmptyEntries);
		foreach (string text in array)
		{
			if (string.IsNullOrEmpty(text))
			{
				continue;
			}
			string[] array2 = text.Split('/');
			bool flag = false;
			if (array2.Length < 7)
			{
				continue;
			}
			string text2 = array2[0];
			string text3 = array2[1];
			string text4 = array2[2];
			int num = int.Parse(array2[3]);
			int num2 = int.Parse(array2[4]);
			Vector3 vector = YelbBackend.StringToVector3(array2[5]);
			Vector3 vector2 = YelbBackend.StringToVector3(array2[6]);
			if (text2 == ModelObject.name && text4 == NameIcon && text3 == ItemTitle && TotalItems == num2)
			{
				if (NewPos != vector)
				{
					vector = NewPos;
					flag = true;
				}
				if (NewRot != vector2)
				{
					vector2 = NewRot;
					flag = true;
				}
			}
			if (!flag)
			{
				list.Add(text);
			}
			if (flag)
			{
				string[] obj = new string[13]
				{
					text2,
					"/",
					text3,
					"/",
					text4,
					"/",
					num.ToString(),
					"/",
					num2.ToString(),
					"/",
					null,
					null,
					null
				};
				Vector3 vector3 = vector;
				obj[10] = vector3.ToString();
				obj[11] = "/";
				vector3 = vector2;
				obj[12] = vector3.ToString();
				string item = string.Concat(obj);
				list.Add(item);
			}
		}
		string information = string.Join("\n", list);
		YelbBackend.SaveData(YelbRef.ContainerGamePlay, information, DataType.stringV);
	}

	public void LoadAllData()
	{
		string[] array = YelbBackend.GetValueFromString(YelbRef.ContainerGamePlay).Split(new char[2]
		{
			'\r',
			'\n'
		}, StringSplitOptions.RemoveEmptyEntries);
		Debug.Log("Array saved : " + array);
		if (array.Length == 0)
		{
			return;
		}
		foreach (string text in array)
		{
			if (string.IsNullOrEmpty(text))
			{
				continue;
			}
			string[] array2 = text.Split('/');
			if (array2.Length < 7)
			{
				continue;
			}
			string text2 = array2[0];
			string text3 = array2[1];
			string b = array2[2];
			int isUsed = int.Parse(array2[3]);
			int num = int.Parse(array2[4]);
			Vector3 position = YelbBackend.StringToVector3(array2[5]);
			Vector3 eulerAngles = YelbBackend.StringToVector3(array2[6]);
			if (text2 == "Interactive Box")
			{
				for (int j = 0; j < ComputerController.COMP.Length; j++)
				{
					ComputerButtons computerButtons = ComputerController.COMP[j];
					for (int k = 0; k < computerButtons.Items.Length; k++)
					{
						ShopItem shopItem = computerButtons.Items[k];
						if (!(shopItem.NameItem == text3) || !(shopItem.ImageIcon.name == b))
						{
							continue;
						}
						GameObject gameObject = UnityEngine.Object.Instantiate(ModsController.BoxSmall);
						YelbBox component = gameObject.GetComponent<YelbBox>();
						gameObject.name = text2;
						if (num == 0)
						{
							component.ItemName = text3;
							component.IconItem = shopItem.ImageIcon;
							component.CountItems = num;
							component.IsUsed = isUsed;
							component.PriceItem = shopItem.PriceItem;
						}
						else
						{
							for (int l = 0; l < num; l++)
							{
								GameObject gameObject2 = UnityEngine.Object.Instantiate(shopItem.OBJ);
								gameObject2.name = shopItem.OBJ.name;
								component.ItemName = text3;
								component.IconItem = shopItem.ImageIcon;
								component.CountItems = num;
								component.IsUsed = isUsed;
								component.PriceItem = shopItem.PriceItem;
								component.Items.Add(gameObject2.transform);
								Transform transform = component.Slots[l].transform;
								gameObject2.transform.parent = transform;
								gameObject2.transform.localPosition = Vector3.zero;
								gameObject2.transform.rotation = Quaternion.identity;
								gameObject2.transform.localScale = new Vector3(0.37f, 0.37f, 0.37f);
								ItemInfo itemInfo = gameObject2.gameObject.AddComponent<ItemInfo>();
								itemInfo.Priceitem = shopItem.PriceItem;
								itemInfo.ItemName = shopItem.NameItem;
								itemInfo.IconItem = shopItem.ImageIcon;
								gameObject2.SetActive(value: true);
							}
						}
						gameObject.transform.position = position;
						gameObject.transform.eulerAngles = eulerAngles;
						gameObject.SetActive(value: true);
					}
				}
				continue;
			}
			if (text2 == "BigBox")
			{
				GameObject gameObject3 = UnityEngine.Object.Instantiate(ModsController.BoxLarg);
				gameObject3.name = ModsController.BoxLarg.name;
				for (int m = 0; m < ComputerController.COMP.Length; m++)
				{
					ComputerButtons computerButtons2 = ComputerController.COMP[m];
					for (int n = 0; n < computerButtons2.Items.Length; n++)
					{
						ShopItem shopItem2 = computerButtons2.Items[n];
						if (shopItem2.NameItem == text3 && shopItem2.ImageIcon.name == b)
						{
							GameObject gameObject4 = UnityEngine.Object.Instantiate(shopItem2.OBJ);
							gameObject4.name = shopItem2.OBJ.name;
							YelbBox component2 = gameObject3.GetComponent<YelbBox>();
							component2.ItemName = shopItem2.NameItem;
							component2.IconItem = shopItem2.ImageIcon;
							component2.CountItems = num;
							component2.Items.Add(gameObject4.transform);
							component2.transform.Find("Canvas").transform.GetChild(0).GetComponent<Image>().sprite = shopItem2.ImageIcon;
							gameObject4.transform.localPosition = Vector3.zero;
							gameObject4.transform.rotation = Quaternion.identity;
							gameObject4.transform.localScale = new Vector3(0.37f, 0.37f, 0.37f);
						}
					}
				}
				gameObject3.transform.position = position;
				gameObject3.transform.eulerAngles = eulerAngles;
				gameObject3.SetActive(value: true);
				continue;
			}
			for (int num2 = 0; num2 < ComputerController.COMP.Length; num2++)
			{
				ComputerButtons computerButtons3 = ComputerController.COMP[num2];
				for (int num3 = 0; num3 < computerButtons3.Items.Length; num3++)
				{
					ShopItem shopItem3 = computerButtons3.Items[num3];
					if (shopItem3.OBJ.name == text2 && shopItem3.ImageIcon.name == b)
					{
						GameObject gameObject5 = UnityEngine.Object.Instantiate(shopItem3.OBJ);
						YelbReference component3 = gameObject5.GetComponent<YelbReference>();
						gameObject5.name = shopItem3.OBJ.name;
						component3.IDIInformation = text;
						component3.IconItem = shopItem3.ImageIcon;
						component3.ItemName = text3;
						component3.IsUsed = isUsed;
						component3.CountItems = num;
						if (shopItem3.ShouldPlaceInside)
						{
							gameObject5.layer = 11;
						}
						else
						{
							gameObject5.layer = 11;
							gameObject5.transform.localScale = new Vector3(1.4f, 1.38f, 1.35f);
						}
						component3.transform.position = position;
						component3.transform.eulerAngles = eulerAngles;
						component3.gameObject.SetActive(value: true);
					}
				}
			}
		}
	}

	public void UpdateBoxsRoom()
	{
		if (YelbBackend.GetValueFromString(YelbRef.ExpandBoxOne) == "done")
		{
			BoxOne.SetActive(value: false);
		}
		if (YelbBackend.GetValueFromString(YelbRef.ExpandBoxTwo) == "done")
		{
			BoxTwo.SetActive(value: false);
		}
	}

	public void SetNameChange()
	{
		BlockTutorial = true;
		UIController.PanelLoginName.SetActive(value: true);
		UIController.PanelLoginName.gameObject.AddComponent<LoginPanel>();
	}

	public void SpawnNotification(List<string> Information, List<ManagerSpawning> Items)
	{
		StartCoroutine(LoadingSpawn(Information));
		if (Items == null)
		{
			return;
		}
		for (int i = 0; i < Items.Count; i++)
		{
			ManagerSpawning managerSpawning = Items[i];
			GameObject gameObject = null;
			int countItems = 0;
			if (!managerSpawning.ShouldPlaceInside)
			{
				if (managerSpawning.IsBigBox)
				{
					YelbBox[] array = UnityEngine.Object.FindObjectsOfType<YelbBox>();
					List<YelbBox> list = new List<YelbBox>();
					for (int j = 0; j < array.Length; j++)
					{
						if (array[j].ItemName == managerSpawning.NameItem)
						{
							list.Add(array[j]);
						}
					}
					countItems = list.Count;
					gameObject = UnityEngine.Object.Instantiate(ModsController.BoxLarg);
					gameObject.transform.position = TransformController.ListBigBox[i].position;
					gameObject.name = ModsController.BoxLarg.name;
				}
				if (!managerSpawning.IsBigBox)
				{
					gameObject = UnityEngine.Object.Instantiate(ModsController.BoxSmall);
					gameObject.transform.position = TransformController.ListSmallBox[i].position;
					gameObject.name = ModsController.BoxSmall.name;
				}
			}
			for (int k = 0; k < managerSpawning.ItemsToSpawn; k++)
			{
				GameObject gameObject2 = UnityEngine.Object.Instantiate(managerSpawning.ModelYelb);
				gameObject2.name = managerSpawning.ModelYelb.name;
				if (managerSpawning.ShouldPlaceInside)
				{
					YelbReference[] array2 = UnityEngine.Object.FindObjectsOfType<YelbReference>();
					List<YelbReference> list2 = new List<YelbReference>();
					for (int l = 0; l < array2.Length; l++)
					{
						if (array2[l].IconItem == managerSpawning.IconItem)
						{
							list2.Add(array2[l]);
						}
					}
					countItems = list2.Count;
					gameObject2.transform.position = TransformController.ListInsideRoom[UnityEngine.Random.Range(0, TransformController.ListInsideRoom.Count)].position;
					gameObject2.transform.rotation = Quaternion.identity;
					gameObject2.layer = 11;
					YelbReference component = gameObject2.GetComponent<YelbReference>();
					gameObject2.name = managerSpawning.ModelYelb.name;
					component.IconItem = managerSpawning.IconItem;
					component.ItemName = managerSpawning.NameItem;
					component.CountItems = countItems;
					continue;
				}
				YelbBox component2 = gameObject.GetComponent<YelbBox>();
				component2.ItemName = managerSpawning.NameItem;
				component2.IconItem = managerSpawning.IconItem;
				component2.PriceItem = managerSpawning.PriceValue;
				component2.CountItems = managerSpawning.ItemsToSpawn;
				if (managerSpawning.IsBigBox)
				{
					component2.CountItems = countItems;
				}
				component2.Items.Add(gameObject2.transform);
				if (!managerSpawning.IsBigBox)
				{
					ItemInfo itemInfo = gameObject2.gameObject.AddComponent<ItemInfo>();
					itemInfo.Priceitem = managerSpawning.PriceValue;
					itemInfo.IconItem = managerSpawning.IconItem;
					itemInfo.ItemName = managerSpawning.NameItem;
					Transform transform = component2.Slots[k].transform;
					gameObject2.transform.parent = transform;
					gameObject2.SetActive(value: true);
				}
				else
				{
					component2.CountItems = countItems;
					component2.transform.Find("Canvas").transform.GetChild(0).GetComponent<Image>().sprite = managerSpawning.IconItem;
				}
				gameObject2.transform.localPosition = Vector3.zero;
				gameObject2.transform.rotation = Quaternion.identity;
				gameObject2.transform.localScale = new Vector3(0.37f, 0.37f, 0.37f);
			}
			if (gameObject != null)
			{
				gameObject.SetActive(value: true);
			}
		}
	}

	public void ActivateInventory(YelbBox BOX, bool Status)
	{
		Button PickUp = LinkerController.PickUp;
		Button InfoPromt = LinkerController.DataPrompt;
		if (Status)
		{
			if (!PickUp.gameObject.activeSelf)
			{
				PickUp.onClick.RemoveAllListeners();
				//_003C_003Ec__DisplayClass39_0 CS_0024_003C_003E8__locals0;
				PickUp.onClick.AddListener(delegate
				{
					//BOX.SpawnBigObject(new Vector3(15, 0, 8));//CS_0024_003C_003E8__locals0._003CActivateInventory_003Eg__TakeAction_007C1();
					BOX.IsOnUses(true, CharacterController.HolderBox);//CS_0024_003C_003E8__locals0._003CActivateInventory_003Eg__TakeAction_007C1();
				});
				PickUp.gameObject.SetActive(value: true);
			}
			if (!InfoPromt.gameObject.activeSelf)
			{
				InfoPromt.transform.GetChild(0).GetComponent<Text>().text = BOX.ItemName;
				InfoPromt.transform.GetChild(1).GetChild(0).GetComponent<Image>()
					.sprite = BOX.IconItem;
				InfoPromt.onClick.RemoveAllListeners();
				InfoPromt.onClick.AddListener(_003CActivateInventory_003Eg__TakeAction_007C39_2);
				InfoPromt.gameObject.SetActive(value: true);
			}
			if (CharacterController.Eraser.gameObject.activeSelf)
			{
				PickUp.gameObject.SetActive(value: false);
				InfoPromt.gameObject.SetActive(value: false);
			}
		}
		if (!Status)
		{
			PickUp.gameObject.SetActive(value: false);
			InfoPromt.gameObject.SetActive(value: false);
		}
	}

	public void SetOutline(bool Status)
	{
		GameObject[] outlineCOMPO = OutlineCOMPO;
		foreach (GameObject gameObject in outlineCOMPO)
		{
			if (gameObject.activeSelf != Status)
			{
				gameObject.SetActive(Status);
			}
		}
	}

	public void SetMusicMode()
	{
		string valueFromString = YelbBackend.GetValueFromString("YelbMusic");
		if (valueFromString == "on")
		{
			base.transform.GetChild(0).GetComponent<AudioSource>().volume = 1f;
			YelbBackend.SaveData("YelbMusic", "off", DataType.stringV);
		}
		else if (valueFromString == "off")
		{
			base.transform.GetChild(0).GetComponent<AudioSource>().volume = 0f;
			YelbBackend.SaveData("YelbMusic", "on", DataType.stringV);
		}
	}

	private IEnumerator LoadingSpawn(List<string> Information)
	{
		bool AddString = false;
		if (Information.Count > 1)
		{
			AddString = true;
			GameObject gameObject = UnityEngine.Object.Instantiate(NotificationPref);
			gameObject.transform.SetParent(NotificationPref.transform.parent);
			gameObject.transform.localScale = NotificationPref.transform.localScale;
			gameObject.GetComponentInChildren<Text>().text = "ITEMS ORDERD";
			gameObject.SetActive(value: true);
			UnityEngine.Object.Destroy(gameObject, UnityEngine.Random.Range(0.7f, 1.7f));
		}
		for (int i = 0; i < Information.Count; i++)
		{
			string Info = " ARRIVED";
			if (!AddString)
			{
				Info = "";
			}
			yield return new WaitForSeconds(0.3f);
			GameObject gameObject2 = UnityEngine.Object.Instantiate(NotificationPref);
			gameObject2.transform.SetParent(NotificationPref.transform.parent);
			gameObject2.transform.localScale = NotificationPref.transform.localScale;
			gameObject2.GetComponentInChildren<Text>().text = Information[i] + Info;
			gameObject2.SetActive(value: true);
			UnityEngine.Object.Destroy(gameObject2, UnityEngine.Random.Range(0.7f, 1.7f));
		}
	}

	private IEnumerator LoadingPosition(List<Transform> Items, List<Transform> Solts, int ElementsToProcess, YelbBox Box, TriggerShelf Shelf)
	{
		yield return new WaitForEndOfFrame();
		int TotalDoneElements = 0;
		if (TotalDoneElements < ElementsToProcess)
		{
			for (int i = 0; i < Items.Count; i++)
			{
				if (i < Solts.Count)
				{
					Items[i].gameObject.SetActive(value: true);
					Items[i].transform.parent = Solts[i];
					Items[i].transform.localEulerAngles = Vector3.zero;
					float ValueToMovePos = 0f;
					float ValueTimeScale = 0f;
					while (ValueToMovePos < 1f)
					{
						Items[i].transform.localPosition = Vector3.Lerp(Items[i].transform.localPosition, Vector3.zero, ValueToMovePos);
						Items[i].transform.localScale = Vector3.Lerp(Items[i].transform.localScale, new Vector3(0.5f, 0.5f, 0.5f), ValueToMovePos);
						ValueToMovePos += Time.deltaTime * 5f;
						yield return null;
					}
					UnityEngine.Object.FindObjectOfType<YelbAudioManager>().StartItemPut();
					while (ValueTimeScale < 1f)
					{
						Items[i].transform.localScale = Vector3.Lerp(Items[i].transform.localScale, Vector3.one * 1.3f, ValueTimeScale);
						ValueTimeScale += Time.deltaTime * 8f;
						yield return null;
					}
				}
				TotalDoneElements++;
			}
		}
		UIController.PanelPrices.SetActive(value: true);
		InputField FieldValueFirst = UIController.PanelPrices.GetComponentInChildren<InputField>(includeInactive: true);
		Button BtnConfirme = UIController.PanelPrices.GetComponentInChildren<Button>(includeInactive: true);
		BtnConfirme.onClick.RemoveAllListeners();
		Text component = UIController.PanelPrices.transform.GetChild(0).GetChild(1).Find("Current Price")
			.GetComponent<Text>();
		Text component2 = UIController.PanelPrices.transform.GetChild(0).GetChild(1).Find("Market Price")
			.GetComponent<Text>();
		UIController.PanelPrices.transform.GetChild(0).GetChild(1).Find("Item Image")
			.GetComponent<Image>()
			.sprite = Box.IconItem;
		component2.text = "Market Price:   " + Box.PriceItem.ToString() + "$";
		component.text = "Current Price: " + Box.PriceItem.ToString() + "$";
		FieldValueFirst.text = (Box.PriceItem.ToString() ?? "");
		if (Shelf.Prices[0].text != "" && !string.IsNullOrEmpty(Shelf.Prices[0].text))
		{
			List<string> information = new List<string>
					{
						"PLACED ITEMS DONE"
					};
			UnityEngine.Object.FindObjectOfType<YelbController>().SpawnNotification(information, null);
			Shelf.UpdateShelfData();
			UIController.PanelPrices.SetActive(value: false);
			BtnConfirme.gameObject.SetActive(value: false);
			yield break;
		}
		/*_003C_003Ec__DisplayClass43_0 CS_0024_003C_003E8__locals0;
		BtnConfirme.onClick.AddListener(delegate
		{
			CS_0024_003C_003E8__locals0._003CLoadingPosition_003Eg__TakeRideAction_007C1();
		});*/
		while (UIController.gameObject.activeSelf)
		{
			if (FieldValueFirst.text == "" || string.IsNullOrEmpty(FieldValueFirst.text))
			{
				BtnConfirme.gameObject.SetActive(value: false);
			}
			else
			{
				BtnConfirme.gameObject.SetActive(value: true);
			}
			yield return null;
		}
	}

	[CompilerGenerated]
	private static void _003CActivateInventory_003Eg__TakeAction_007C39_2()
	{
	}
}
