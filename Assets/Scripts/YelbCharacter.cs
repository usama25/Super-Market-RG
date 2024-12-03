// DecompilerFi decompiler from Assembly-CSharp.dll class: YelbCharacter
using System.Collections;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine;
using UnityEngine.UI;
using Yelbouziani;
using Yelbouziani.Enum;
using Yelbouziani.Helper;

public class YelbCharacter : MonoBehaviour
{
	[Header("Manager")]
	public CharacterController _Controller;

	public YelbController _YelbController;

	public BooleanManager BOOL;

	public StringsManager STINGCONTROLLER;

	public CashRegister CashData;

	[Header("Floating")]
	public float SpeedMovement = 8f;

	public float SenstiveCamX = 6f;

	public float SenstiveCamY = 6f;

	public float Distance = 6f;

	[Header("Transform")]
	public Transform CameraTransform;

	public Transform Eraser;

	public Transform HolderBox;

	[Header("Layers")]
	public LayerMask SkipMask;

	[Header("Objects")]
	internal Transform DoorActive;

	internal Transform OBJMoving;

	internal Transform SelectedTarget;

	internal Transform LastActiveItem;

	internal Transform LastShelf;

	[Header("Holder")]
	internal YelbBox BoxHolding;

	[Header("List")]
	internal List<YelbBox> InteractHistroy = new List<YelbBox>();

	internal List<TriggerShelf> ShelfingTriggers = new List<TriggerShelf>();

	[Header("Vectors")]
	internal Vector3 PositionCamera = Vector3.zero;

	internal Vector3 RotationCamera = Vector3.zero;

	private void Awake()
	{
		StartCoroutine(adsCheck());
		CashData = UnityEngine.Object.FindObjectOfType<CashRegister>(includeInactive: true);
		BOOL = base.gameObject.AddComponent<BooleanManager>();
		STINGCONTROLLER = base.gameObject.AddComponent<StringsManager>();
        if (!PlayerPrefs.HasKey("openAds"))
        {
			PlayerPrefs.SetInt("openAds", 1);
        }
        else
        {
			//if (AdsManager.instance)
				//AdsManager.instance.Show_AdMob_Interstitial();
		}
	}

	private void Update()
	{
		ManagerLogic();
		ManagerCamera();
	}

	IEnumerator adsCheck()
    {
        while (true)
        {
			yield return new WaitForSeconds(1);
			timer++;
			if(timer > interAdsTreshold)
            {
				timer = 0;
				//if (AdsManager.instance)
					//AdsManager.instance.Show_AdMob_Interstitial();
			}
			yield return null;
        }
    }

	private void LateUpdate()
	{
		if (!BOOL.IsMoveCameraForPay && !BOOL.IsCharacterBlocked && (BOOL.IsStoreStart || _YelbController.IsStartGame))
		{
			if (!BOOL.IsLocked)
			{
				YelbBackend.DirectionMovingCharacterController(_Controller, CameraTransform, SpeedMovement);
			}
			YelbBackend.CameraLooking(CameraTransform, CameraTransform, 0f, SenstiveCamX, SenstiveCamY, Vector3.zero, CameraMods.fps);
		}
	}

	private void ManagerCamera()
	{
		if (BOOL.IsLocked)
		{
			SenstiveCamX = 6f * YelbBackend.GetValueFromFloat(YelbRef.ValueCashier);
			SenstiveCamY = 6f * YelbBackend.GetValueFromFloat(YelbRef.ValueCashier);
		}
		else
		{
			SenstiveCamX = 12f * YelbBackend.GetValueFromFloat(YelbRef.ValueLookX);
			SenstiveCamY = 12f * YelbBackend.GetValueFromFloat(YelbRef.ValueLookY);
		}
	}

	private void CloseOutline()
	{
		foreach (YelbBox item in InteractHistroy)
		{
			if (item != null)
			{
				item.SetOutline(Status: false);
			}
		}
		_YelbController.SetOutline(Status: false);
	}

	private void ManagerLogic()
	{
		RaycastHit raycastHit = YelbBackend.IsArrivedTarget(CameraTransform, MoveDirectoin.Forward, Distance, Vector3.zero, default(LayerMask));
		if (raycastHit.collider != null)
		{
			if (BOOL.IsBusyWithItems && BOOL.IsLocked)
			{
				if (!(raycastHit.collider.gameObject != null))
				{
					return;
				}
				if (BOOL.IsCheckingMethode)
				{
					if (raycastHit.collider.GetComponent<CardID>() != null && !_YelbController.LinkerController.BtnInteract.gameObject.activeSelf)
					{
						UnityEngine.Debug.Log(" raycastHit ManagerLogic");
						Button btnInteract = _YelbController.LinkerController.BtnInteract;
						btnInteract.onClick.RemoveAllListeners();
						btnInteract.onClick.AddListener(delegate
						{
							_003CManagerLogic_003Eg__TakeAction_007C28_2();
						});
						_YelbController.LinkerController.BtnInteract.interactable = true;
						_YelbController.LinkerController.BtnInteract.gameObject.SetActive(value: true);
					}
					return;
				}
				ItemInfo Information = raycastHit.collider.GetComponent<ItemInfo>();
				if (Information != null)
				{
					//UnityEngine.Debug.Log(" Information ManagerLogic");
					_YelbController.ModsController.SetHigh(raycastHit.collider.gameObject, Up: true);
					if (!_YelbController.LinkerController.BtnInteract.gameObject.activeSelf)
					{
						Button ClickItem = _YelbController.LinkerController.BtnInteract;
						ClickItem.onClick.RemoveAllListeners();
						//UnityEngine.Debug.Log(" ClickItem ManagerLogic");
						//_003C_003Ec__DisplayClass28_1 CS_0024_003C_003E8__locals3;
						ClickItem.onClick.AddListener(delegate
						{
							//CS_0024_003C_003E8__locals3._003CManagerLogic_003Eg__TakeAction_007C7();
							Debug.Log("Pass item");
							CashData.MoveItemToScan(Information);
						});
						_YelbController.LinkerController.BtnInteract.interactable = true;
						_YelbController.LinkerController.BtnInteract.gameObject.SetActive(value: true);
					}
				}
				else
				{
					_YelbController.LinkerController.BtnInteract.gameObject.SetActive(value: false);
				}
				return;
			}
			if (SelectedTarget != raycastHit.collider.transform)
			{
				YelbBox[] array = UnityEngine.Object.FindObjectsOfType<YelbBox>();
				for (int i = 0; i < array.Length; i++)
				{
					array[i].SetOutline(Status: false);
				}
				_YelbController.SetOutline(Status: false);
				SelectedTarget = raycastHit.collider.transform;
			}
			int layer = raycastHit.collider.gameObject.layer;
			if (BOOL.IsMovingObject && !BOOL.IsHoldingBox && !BOOL.IsHoldingBigBox)
			{
				CloseOutline();
				Distance = 8f;
				raycastHit = YelbBackend.IsArrivedTarget(CameraTransform, MoveDirectoin.Forward, Distance, Vector3.zero, SkipMask);
				Vector3 point = raycastHit.point;
				OBJMoving.GetComponentInChildren<YelbReference>().SetPositionGhost(point, Action: true);
			}
			else if (BOOL.IsHoldingBox && !BOOL.IsMovingObject && !BOOL.IsHoldingBigBox)
			{
				CloseOutline();
				Distance = 8f;
				raycastHit = YelbBackend.IsArrivedTarget(CameraTransform, MoveDirectoin.Forward, Distance, Vector3.zero, SkipMask);
				Vector3 point2 = raycastHit.point;
				float fixedPositionY = 0.3718468f;
				if (raycastHit.collider != null && raycastHit.collider.gameObject.name.StartsWith("Interactive Box"))
				{
					fixedPositionY = point2.y;
				}
				if ((raycastHit.collider != null && raycastHit.collider.gameObject.GetComponent<TriggerShelf>() != null) || (raycastHit.collider != null && raycastHit.collider.gameObject.GetComponent<YelbShelf>() != null) || (raycastHit.collider != null && raycastHit.collider.gameObject.name == "PriceTag") || (raycastHit.collider != null && raycastHit.collider.gameObject.name == "PriceBG") || (raycastHit.collider != null && raycastHit.collider.GetComponent<SetPrice>() != null))
				{
					if (LastShelf != raycastHit.collider.transform)
					{
						_YelbController.LinkerController.FillShelfBtn.gameObject.SetActive(value: false);
						LastShelf = raycastHit.collider.transform;
					}
					if (raycastHit.collider.gameObject.GetComponent<TriggerShelf>() != null)
					{
						TriggerShelf ShelfTrigger = raycastHit.collider.gameObject.GetComponent<TriggerShelf>();
						ShelfTrigger.SetActionToggle();
						if (!_YelbController.LinkerController.FillShelfBtn.gameObject.activeSelf)
						{
							Button ShelfBtn = _YelbController.LinkerController.FillShelfBtn;
							ShelfBtn.onClick.RemoveAllListeners();
							//_003C_003Ec__DisplayClass28_2 CS_0024_003C_003E8__locals2;
							ShelfBtn.onClick.AddListener(delegate
							{
								//CS_0024_003C_003E8__locals2._003CManagerLogic_003Eg__TakeAction_007C9(BoxHolding, ShelfTrigger);
								Debug.Log("Put Object");
								if (BoxHolding.Items.Count > 0)
								{
									// Items Box Has : BoxHolding.Items
									// Position : ShelfTrigger.SlotsMenu[TotalItems]
									BoxHolding.Items[0].gameObject.SetActive(true);
									BoxHolding.Items[0].parent = ShelfTrigger.SlotsMenu[ShelfTrigger.TotalItems];
									BoxHolding.Items[0].localPosition = Vector3.zero;
									BoxHolding.Items[0].localRotation = Quaternion.identity;
									BoxHolding.Items[0].localScale = new Vector3(1, 1, 1);
									ShelfTrigger.UpdateShelfData();
									BoxHolding.Items.RemoveAt(0);
								}
								/*
								 * Steps : 
								 *  1 - Select Items that box has
								 *  2 - Select Where to put the item
								 *  3 - Put First Item on the shelf
								 *  4 - Remove first item from the box.items
								 *  & - Debug Actions
								 */
							});

							_YelbController.LinkerController.FillShelfBtn.gameObject.SetActive(value: true);
						}
						if (!ShelfingTriggers.Contains(ShelfTrigger))
						{
							ShelfingTriggers.Add(ShelfTrigger);
						}

					}
					_YelbController.LinkerController.DropBtn.gameObject.SetActive(value: false);
					BoxHolding.SetHide();
					return;
				}
				_YelbController.LinkerController.FillShelfBtn.gameObject.SetActive(value: false);
				foreach (TriggerShelf shelfingTrigger in ShelfingTriggers)
				{
					shelfingTrigger.DisableToggle();
				}
				if (ShelfingTriggers.Count > 0)
				{
					ShelfingTriggers.Clear();
				}
				if (point2.x != 0f && point2.z != 0f && raycastHit.collider != null)
				{
					BoxHolding.SetPosLocated(point2, fixedPositionY);
					_YelbController.LinkerController.DropBtn.gameObject.SetActive(value: true);
					Button DropBtn = _YelbController.LinkerController.DropBtn;
					DropBtn.onClick.RemoveAllListeners();
					DropBtn.onClick.AddListener(delegate
					{
						Debug.Log("Drop");
						BoxHolding.IsOnUses(false, null);
					});
					_YelbController.LinkerController.DropBtn.interactable = true;
				}
				else
				{
					_YelbController.LinkerController.DropBtn.gameObject.SetActive(value: true);
					_YelbController.LinkerController.DropBtn.interactable = false;
					BoxHolding.SetHide();
				}
			}
			else if (BOOL.IsHoldingBigBox && !BOOL.IsHoldingBox && !BOOL.IsMovingObject)
			{
				if (BoxHolding != null)
				{
					CloseOutline();
					Distance = 8f;
					raycastHit = YelbBackend.IsArrivedTarget(CameraTransform, MoveDirectoin.Forward, Distance, Vector3.zero, SkipMask);
					Vector3 point3 = raycastHit.point;
					if (!_YelbController.LinkerController.RotateLeft.gameObject.activeSelf)
					{
						_YelbController.LinkerController.RotateLeft.onClick.RemoveAllListeners();
						_YelbController.LinkerController.RotateLeft.onClick.AddListener(_003CManagerLogic_003Eg__RotateLeft_007C28_10);
						_YelbController.LinkerController.RotateLeft.gameObject.SetActive(value: true);
					}
					if (!_YelbController.LinkerController.RotateRight.gameObject.activeSelf)
					{
						_YelbController.LinkerController.RotateRight.onClick.RemoveAllListeners();
						_YelbController.LinkerController.RotateRight.onClick.AddListener(_003CManagerLogic_003Eg__RotateRight_007C28_11);
						_YelbController.LinkerController.RotateRight.gameObject.SetActive(value: true);
					}
					if (!_YelbController.LinkerController.PlaceBtn.gameObject.activeSelf && !BoxHolding.BoxBigInislized)
					{
						_YelbController.LinkerController.PlaceBtn.onClick.RemoveAllListeners();
						_YelbController.LinkerController.PlaceBtn.onClick.AddListener(_003CManagerLogic_003Eg__PlaceIN_007C28_12);
						BoxHolding.BoxBigInislized = true;
					}
					if (!InteractHistroy.Contains(BoxHolding))
					{
						InteractHistroy.Add(BoxHolding);
					}
					if (point3 != Vector3.zero)
					{
						_YelbController.LinkerController.PlaceBtn.gameObject.SetActive(value: true);
						BoxHolding.StartHoldBoxBig(point3, IsActive: true);
					}
					else
					{
						_YelbController.LinkerController.PlaceBtn.gameObject.SetActive(value: false);
						BoxHolding.StartHoldBoxBig(point3, IsActive: false);
					}
				}
			}
			else if (raycastHit.collider.gameObject != null && raycastHit.collider.GetComponent<SetPrice>() != null)
			{
				SetPrice component = raycastHit.collider.GetComponent<SetPrice>();
				TriggerShelf Shelf = component.Shelf;
				bool flag = false;
				for (int j = 0; j < component.Shelf.SlotsMenu.Length; j++)
				{
					if (component.Shelf.SlotsMenu[j].childCount > 0)
					{
						flag = true;
					}
				}
				if (flag)
				{
					_YelbController.LinkerController.MoveBtn.gameObject.SetActive(value: false);
					if (!_YelbController.LinkerController.ChangePriceBtn.gameObject.activeSelf)
					{
						Button changePriceBtn = _YelbController.LinkerController.ChangePriceBtn;
						changePriceBtn.onClick.RemoveAllListeners();
						/*_003C_003Ec__DisplayClass28_3 CS_0024_003C_003E8__locals1;
						changePriceBtn.onClick.AddListener(delegate
						{
							CS_0024_003C_003E8__locals1._003CManagerLogic_003Eg__TakeAction_007C14();
						});*/
						_YelbController.LinkerController.ChangePriceBtn.gameObject.SetActive(value: true);
					}
				}
			}
			else
			{
				_YelbController.LinkerController.ChangePriceBtn.gameObject.SetActive(value: false);
				_YelbController.LinkerController.DropBtn.gameObject.SetActive(value: false);
				Distance = 6f;
				if (layer == 11)
				{
					if (!_YelbController.LinkerController.MoveBtn.gameObject.activeSelf && !BOOL.IsMovingObject && !BOOL.IsHoldingBox && !BOOL.IsHoldingBigBox)
					{
						_YelbController.LinkerController.MoveBtn.onClick.RemoveAllListeners();
						_YelbController.LinkerController.MoveBtn.onClick.AddListener(_003CManagerLogic_003Eg__TakeAction_007C28_0);
						OBJMoving = raycastHit.collider.transform;
						if (!Eraser.gameObject.activeSelf)
						{
							_YelbController.LinkerController.MoveBtn.gameObject.SetActive(value: true);
						}
						else
						{
							_YelbController.LinkerController.MoveBtn.gameObject.SetActive(value: false);
						}
					}
				}
				else
				{
					_YelbController.LinkerController.MoveBtn.gameObject.SetActive(value: false);
				}
				if (layer == 12)
				{
					if (raycastHit.collider.gameObject.name.StartsWith("BigBox") && !BOOL.IsHoldingBigBox && !BOOL.IsHoldingBox && !BOOL.IsMovingObject)
					{
						//UnityEngine.Debug.Log("YelbBox");
						YelbBox Box = raycastHit.collider.gameObject.GetComponent<YelbBox>();
						Button ClickBigBox = _YelbController.LinkerController.UnpackItem;
						BoxHolding = Box;
						//BoxHolding.ActivateBigOutline(Status: true);
						//_YelbController.SetOutline(Status: true);
						if (!Eraser.gameObject.activeSelf)
						{
							if (!ClickBigBox.gameObject.activeSelf && !Box.BoxInUse)
							{
								ClickBigBox.onClick.RemoveAllListeners();

								//_003C_003Ec__DisplayClass28_5 CS_0024_003C_003E8__locals0;
								ClickBigBox.onClick.AddListener(delegate
								{
									UnityEngine.Debug.Log("Select YelbBox");
									Vector3 pos = Box.gameObject.transform.position;
									pos.y = 0.27f;
									Box.SpawnBigObject(pos);
								});
								ClickBigBox.gameObject.SetActive(value: true);
							}
						}
						else
						{
							ClickBigBox.gameObject.SetActive(value: false);
						}
						return;
					}
					CloseOutline();
					if (BoxHolding != null)
					{
						BoxHolding.ActivateBigOutline(Status: false);
					}
					_YelbController.LinkerController.UnpackItem.gameObject.SetActive(value: false);
				}
				else
				{
					CloseOutline();
					InteractHistroy.Clear();
					if (BoxHolding != null)
					{
						BoxHolding.ActivateBigOutline(Status: false);
					}
					_YelbController.LinkerController.UnpackItem.gameObject.SetActive(value: false);
				}
				if (layer == 6)
				{
					if (!BOOL.IsMovingObject && !BOOL.IsHoldingBigBox)
					{
						if (raycastHit.collider.gameObject.name.StartsWith("Interactive Box"))
						{
							UnityEngine.Debug.Log("Interactive Box");
							if (raycastHit.collider.gameObject.GetComponent<YelbBox>() != null)
							{
								//raycastHit.collider.gameObject.GetComponent<YelbBox>().SetOutline(Status: true);
							}
							if (!InteractHistroy.Contains(raycastHit.collider.GetComponent<YelbBox>()))
							{
								InteractHistroy.Add(raycastHit.collider.GetComponent<YelbBox>());
							}
							_YelbController.ActivateInventory(raycastHit.collider.GetComponent<YelbBox>(), Status: true);
							_YelbController.SetOutline(Status: true);
							return;
						}
						CloseOutline();
						_YelbController.ActivateInventory(null, Status: false);
						_YelbController.SetOutline(Status: false);
					}
				}
				else
				{
					CloseOutline();
					_YelbController.ActivateInventory(null, Status: false);
					_YelbController.SetOutline(Status: false);
				}
			}
			if (layer == 15)
			{
				if (LastActiveItem != raycastHit.collider.gameObject.transform)
				{
					_YelbController.LinkerController.BtnInteract.onClick.RemoveAllListeners();
					_YelbController.LinkerController.BtnInteract.gameObject.SetActive(value: false);
					_YelbController.LinkerController.BtnInteract.interactable = false;
					LastActiveItem = raycastHit.collider.gameObject.transform;
				}
				if (raycastHit.collider.gameObject.name.ToLower().StartsWith("door"))
				{
					//UnityEngine.Debug.Log("door");
					_YelbController.ModsController.SetHigh(raycastHit.collider.gameObject, Up: true);
					_YelbController.LinkerController.BtnInteract.gameObject.SetActive(value: true);
					if (!_YelbController.LinkerController.BtnInteract.interactable)
					{
						Door door = raycastHit.collider.gameObject.GetComponent<Door>();
						if (door == null)
						{
							door = raycastHit.collider.gameObject.AddComponent<Door>();
						}
						if ((DoorActive == null || DoorActive != raycastHit.collider.gameObject.transform) && door != null)
						{
							door.IsInisilized = false;
							DoorActive = raycastHit.collider.gameObject.transform;
						}
						if (door != null && !door.IsInisilized)
						{
							//_003C_003Ec__DisplayClass28_6 @object;
							//_YelbController.LinkerController.BtnInteract.onClick.AddListener(@object._003CManagerLogic_003Eg__SetDoor_007C22);
							_YelbController.LinkerController.BtnInteract.onClick.AddListener(() =>
							{
								if (door.opened)
								{
									StartCoroutine(door.LoadingDoor(true));
									door.opened = false;
								}
								else
								{
									StartCoroutine(door.LoadingDoor(false));
									door.opened = true;
								}
							});

							door.IsInisilized = true;
						}
						_YelbController.LinkerController.BtnInteract.interactable = true;
					}
				}
				if (!raycastHit.collider.gameObject.name.StartsWith("InteractComputer"))
				{
					return;
				}
				_YelbController.ModsController.SetHigh(raycastHit.collider.gameObject, Up: true);
				if (!_YelbController.LinkerController.BtnInteract.interactable)
				{
					Door[] array2 = UnityEngine.Object.FindObjectsOfType<Door>();
					for (int i = 0; i < array2.Length; i++)
					{
						array2[i].IsInisilized = false;
					}
					_YelbController.LinkerController.BtnInteract.gameObject.SetActive(value: true);
					_YelbController.LinkerController.BtnInteract.onClick.AddListener(_003CManagerLogic_003Eg__SetComputer_007C28_23);
					_YelbController.LinkerController.BtnInteract.interactable = true;
				}
			}
			else
			{
				_YelbController.LinkerController.BtnInteract.gameObject.SetActive(value: false);
				_YelbController.LinkerController.BtnInteract.interactable = false;
			}
		}
		else if (_YelbController != null && _YelbController.LinkerController != null && _YelbController.LinkerController.BtnInteract != null)
		{
			if (BoxHolding != null)
			{
				BoxHolding.ActivateBigOutline(Status: false);
			}
			_YelbController.LinkerController.UnpackItem.gameObject.SetActive(value: false);
			_YelbController.LinkerController.BtnInteract.gameObject.SetActive(value: false);
			_YelbController.LinkerController.MoveBtn.gameObject.SetActive(value: false);
			_YelbController.LinkerController.BtnInteract.interactable = false;
			_YelbController.LinkerController.DropBtn.gameObject.SetActive(value: false);
			_YelbController.LinkerController.ChangePriceBtn.gameObject.SetActive(value: false);
			_YelbController.LinkerController.PickUp.gameObject.SetActive(value: false);
			_YelbController.LinkerController.DataPrompt.gameObject.SetActive(value: false);
		}
	}

	public void SetEraser(bool Status)
	{
		if (!BOOL.IsHoldingBigBox && !BOOL.IsHoldingBox && !Object.FindObjectOfType<CashRegister>().IsLocked)
		{
			if (Status)
			{
				STINGCONTROLLER.ModeActiveErased = "true";
			}
			if (!Status)
			{
				STINGCONTROLLER.ModeActiveErased = "false";
			}
			BOOL.IsEraser = Status;
			Eraser.gameObject.SetActive(Status);
		}
	}

	public Sprite IconItem(string IcnName)
	{
		for (int i = 0; i < _YelbController.ComputerController.COMP.Length; i++)
		{
			ComputerButtons computerButtons = _YelbController.ComputerController.COMP[i];
			for (int j = 0; j < computerButtons.Items.Length; j++)
			{
				ShopItem shopItem = computerButtons.Items[j];
				if (shopItem.ImageIcon.name == IcnName)
				{
					return shopItem.ImageIcon;
				}
			}
		}
		return null;
	}

	private IEnumerator ResetCameraPosition(bool Moving)
	{
		float duration = 2f;
		float timeElapsed = 0f;
		while (timeElapsed < duration)
		{
			float t = timeElapsed / duration;
			if (Moving)
			{
				CameraTransform.position = Vector3.Lerp(CameraTransform.position, CashData.CameraReference.position, t);
				CameraTransform.rotation = Quaternion.Lerp(CameraTransform.rotation, CashData.CameraReference.rotation, t);
			}
			else
			{
				if (Vector3.Distance(CameraTransform.localPosition, PositionCamera) < 0.003497599f)
				{
					timeElapsed = duration;
				}
				CameraTransform.localPosition = Vector3.Lerp(CameraTransform.localPosition, PositionCamera, t);
				CameraTransform.localRotation = Quaternion.Lerp(CameraTransform.localRotation, Quaternion.Euler(RotationCamera), t);
			}
			timeElapsed += Time.deltaTime;
			yield return null;
		}
		if (Moving)
		{
			CameraTransform.position = CashData.CameraReference.position;
			CameraTransform.rotation = CashData.CameraReference.rotation;
		}
		else
		{
			CameraTransform.localPosition = PositionCamera;
			CameraTransform.localRotation = Quaternion.Euler(RotationCamera);
		}
		if (!Moving)
		{
			BOOL.IsCheckingMethode = false;
			BOOL.IsMoveCameraForPay = false;
		}
	}

	int leaveTimes;
	int timesStampsToWatchAds = 4;
	int timer;
	int interAdsTreshold = 350;
	private void OnTriggerEnter(Collider other)
	{
		if (other.name == "CashierTrigger" && !BOOL.IsHoldingBox && !BOOL.IsHoldingBigBox)
		{
			if (!_YelbController.LinkerController.LeaveCash.gameObject.activeSelf)
			{
				Object.FindObjectOfType<CashRegister>().IsLocked = true;
				BOOL.IsLocked = true;
				_YelbController.LinkerController.LeaveCash.onClick.RemoveAllListeners();
				_YelbController.LinkerController.LeaveCash.onClick.AddListener(delegate
				{
					Debug.Log("Leave");
					leaveTimes++;
					if(leaveTimes >= timesStampsToWatchAds)
                    {
						//if (AdsManager.instance)
							//AdsManager.instance.Show_AdMob_Interstitial();
					}
					_003COnTriggerEnter_003Eg__TakeAction_007C32_1();
				});
				CameraTransform.transform.rotation = Quaternion.Euler(7.937f, -60.583f, 0f);
				_YelbController.UIController.PanelJoystick.SetActive(value: false);
				_YelbController.LinkerController.LeaveCash.gameObject.SetActive(value: true);
			}
			BOOL.IsEraser = false;
			Eraser.gameObject.SetActive(value: false);
		}
		if (other.name == "TriggerTrash")
		{
			Object.FindObjectOfType<Dumpset>().OpenBox(Status: true);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (other.name == "TriggerTrash")
		{
			Object.FindObjectOfType<Dumpset>().OpenBox(Status: false);
		}
	}



	[CompilerGenerated]
	private void _003CManagerLogic_003Eg__TakeAction_007C28_2()
	{
		Debug.Log("_003CManagerLogic_003Eg__TakeAction_007C28_2");
		Object.FindObjectOfType<YelbAudioManager>().ClickSound.Play();
		YelbNPC.NPC NPC = CashData.UsingCharacter.GetComponent<YelbNPC.NPC>();
		Transform bankInput = CashData.BankInput;
		GameObject PlayGlow = bankInput.GetChild(0).gameObject;
		GameObject ArrowGlow = bankInput.GetChild(1).GetChild(1).GetChild(0)
			.GetChild(0)
			.gameObject;
		GameObject PanelContainer = bankInput.GetChild(1).GetChild(1).GetChild(0)
			.gameObject;
		Button CheckValue = bankInput.GetChild(1).GetChild(0).GetComponent<Button>();
		InputField FieldInformation = bankInput.GetChild(1).GetChild(1).GetChild(0)
			.GetChild(2)
			.gameObject.GetComponent<InputField>();
		NPC.Bankcard.gameObject.SetActive(value: false);
		NPC.CashHandy.gameObject.SetActive(value: false);
		PanelContainer.gameObject.SetActive(value: true);
		ArrowGlow.gameObject.SetActive(value: true);
		CheckValue.onClick.RemoveAllListeners();
		//_003C_003Ec__DisplayClass28_0 CS_0024_003C_003E8__locals0;
		FieldInformation.onValueChanged.AddListener(delegate
		{
			Debug.Log("value changed");//CS_0024_003C_003E8__locals0._003CManagerLogic_003Eg__EventClickInputField_007C5
			CashData.BankInput.GetChild(0).gameObject.SetActive(true);
		}
		);
		CheckValue.onClick.AddListener(delegate
		{
			//CS_0024_003C_003E8__locals0._003CManagerLogic_003Eg__BtnCheckingPaid_007C4();
			Debug.Log("check value btn listener");
			string price = "";
			for(int i = 0; i < CashData.PriceTotal.text.Length - 1; i++)
            {
				price += CashData.PriceTotal.text[i];
			}
			Debug.Log("Price is : " + price);
			if (FieldInformation.text != price)
            {
				Debug.Log("wrong value !");
            }
            else
            {
				CashData.BankInput.GetChild(0).gameObject.SetActive(false);
				Debug.Log("correct value !");
				CashData.removeClient(NPC);
				StartCoroutine(ResetCameraPosition(false));
				_YelbController.UIController.PanelController.SetActive(value: true);
				_YelbController.LinkerController.LeaveCash.gameObject.SetActive(value: true);
				_YelbController.LinkerController.BtnInteract.gameObject.SetActive(value: true);
				BOOL.IsMoveCameraForPay = false;
				FieldInformation.text = "";
				PlayerPrefs.SetFloat("CashValue" , PlayerPrefs.GetFloat("CashValue") + float.Parse(price));
			}
			/*
			 * Check product and value of the introduced value
			 *  |-- if true  : pass client 
			 *    |-- 
			 *  |-- if false : debug error
			 */
		});
		Debug.Log("Call Btn");
		PositionCamera = CameraTransform.localPosition;
		RotationCamera = CameraTransform.localEulerAngles;
		BOOL.IsMoveCameraForPay = true;
		StartCoroutine(ResetCameraPosition(Moving: true));
		_YelbController.UIController.PanelController.SetActive(value: false);
		_YelbController.LinkerController.LeaveCash.gameObject.SetActive(value: false);
		_YelbController.LinkerController.BtnInteract.gameObject.SetActive(value: false);
	}

	[CompilerGenerated]
	private void _003CManagerLogic_003Eg__RotateLeft_007C28_10()
	{
		Object.FindObjectOfType<YelbAudioManager>().ClickSound.Play();
		BoxHolding.RotationAxis += new Vector3(0f, 90f, 0f);
	}

	[CompilerGenerated]
	private void _003CManagerLogic_003Eg__RotateRight_007C28_11()
	{
		Object.FindObjectOfType<YelbAudioManager>().ClickSound.Play();
		BoxHolding.RotationAxis -= new Vector3(0f, 90f, 0f);
	}

	[CompilerGenerated]
	private void _003CManagerLogic_003Eg__PlaceIN_007C28_12()
	{
		Object.FindObjectOfType<YelbAudioManager>().ClickSound.Play();
		_YelbController.LinkerController.PlaceBtn.gameObject.gameObject.SetActive(value: false);
		_YelbController.LinkerController.RotateLeft.gameObject.gameObject.SetActive(value: false);
		_YelbController.LinkerController.RotateRight.gameObject.gameObject.SetActive(value: false);
		_YelbController.UIController.PanelGhost.gameObject.SetActive(value: false);
		BoxHolding.SpawnBigObject();
		BOOL.IsHoldingBigBox = false;
	}

	[CompilerGenerated]
	private void _003CManagerLogic_003Eg__TakeAction_007C28_0()
	{
		Object.FindObjectOfType<YelbAudioManager>().ClickSound.Play();
		BOOL.IsMovingObject = true;
		_YelbController.UIController.PanelGhost.SetActive(value: true);
		if (!_YelbController.LinkerController.PlaceBtn.gameObject.activeSelf)
		{
			_YelbController.LinkerController.PlaceBtn.onClick.RemoveAllListeners();
			_YelbController.LinkerController.PlaceBtn.onClick.AddListener(_003CManagerLogic_003Eg__PlaceIN_007C28_17);
			_YelbController.LinkerController.PlaceBtn.gameObject.SetActive(value: true);
		}
		if (!_YelbController.LinkerController.RotateLeft.gameObject.activeSelf)
		{
			_YelbController.LinkerController.RotateLeft.onClick.RemoveAllListeners();
			_YelbController.LinkerController.RotateLeft.onClick.AddListener(_003CManagerLogic_003Eg__RotateLeft_007C28_18);
			_YelbController.LinkerController.RotateLeft.gameObject.SetActive(value: true);
		}
		if (!_YelbController.LinkerController.RotateRight.gameObject.activeSelf)
		{
			_YelbController.LinkerController.RotateRight.onClick.RemoveAllListeners();
			_YelbController.LinkerController.RotateRight.onClick.AddListener(_003CManagerLogic_003Eg__RotateRight_007C28_19);
			_YelbController.LinkerController.RotateRight.gameObject.SetActive(value: true);
		}
		_YelbController.LinkerController.MoveBtn.gameObject.SetActive(value: false);
	}

	[CompilerGenerated]
	private void _003CManagerLogic_003Eg__PlaceIN_007C28_17()
	{
		Object.FindObjectOfType<YelbAudioManager>().ClickSound.Play();
		_YelbController.LinkerController.PlaceBtn.gameObject.gameObject.SetActive(value: false);
		_YelbController.LinkerController.RotateLeft.gameObject.gameObject.SetActive(value: false);
		_YelbController.LinkerController.RotateRight.gameObject.gameObject.SetActive(value: false);
		_YelbController.UIController.PanelGhost.gameObject.SetActive(value: false);
		OBJMoving.GetComponentInChildren<YelbReference>().DropIt();
		BOOL.IsMovingObject = false;
	}

	[CompilerGenerated]
	private void _003CManagerLogic_003Eg__RotateLeft_007C28_18()
	{
		Object.FindObjectOfType<YelbAudioManager>().ClickSound.Play();
		if (OBJMoving != null)
		{
			OBJMoving.GetComponent<YelbReference>().RotationTo += new Vector3(0f, 90f, 0f);
		}
	}

	[CompilerGenerated]
	private void _003CManagerLogic_003Eg__RotateRight_007C28_19()
	{
		Object.FindObjectOfType<YelbAudioManager>().ClickSound.Play();
		if (OBJMoving != null)
		{
			OBJMoving.GetComponent<YelbReference>().RotationTo -= new Vector3(0f, 90f, 0f);
		}
	}

	[CompilerGenerated]
	private void _003CManagerLogic_003Eg__SetComputer_007C28_23()
	{
		Object.FindObjectOfType<YelbAudioManager>().ClickSound.Play();
		_YelbController.UIController.PanelComputer.SetActive(value: true);
	}

	[CompilerGenerated]
	private void _003COnTriggerEnter_003Eg__TakeAction_007C32_1()
	{
		Object.FindObjectOfType<YelbAudioManager>().ClickSound.Play();
		CameraTransform.transform.rotation = Quaternion.Euler(21.88f, 71.944f, 0f);
		BOOL.IsLocked = false;
		Object.FindObjectOfType<CashRegister>().IsLocked = false;
		base.transform.position = new Vector3(_YelbController.TransformController.TargetOutCash.position.x, base.transform.position.y, _YelbController.TransformController.TargetOutCash.position.z);
		if (STINGCONTROLLER.ModeActiveErased == "true")
		{
			SetEraser(Status: true);
		}
		_YelbController.UIController.PanelJoystick.SetActive(value: true);
		_YelbController.UIController.PanelController.SetActive(value: true);
		_Controller.enabled = true;
		_YelbController.LinkerController.LeaveCash.gameObject.SetActive(value: false);
	}
}
