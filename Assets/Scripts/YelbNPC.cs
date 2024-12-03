// DecompilerFi decompiler from Assembly-CSharp.dll class: YelbNPC
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.AI;
using Yelbouziani;
using Yelbouziani.Enum;

public class YelbNPC : MonoBehaviour
{
	public class NPC : MonoBehaviour
	{
		[Header("Managers")]
		internal NavMeshAgent Agent;

		internal CapsuleCollider Cold;

		internal Animator Anim;

		internal YelbNPC ManagerNPC;

		internal YelbShelf SelectedShelf;

		internal BooleanManager BOOL;

		internal YelbController Controller;

		internal CashRegister CashRegister;

		internal ComputerController ComputerController;

		[Header("Transform")]
		internal Transform Target;

		internal Transform StartPosition;

		internal Transform EndPosition;

		internal Transform LookAtWindow;

		internal Transform PayingZone;

		[Header("Transform")]
		internal Transform ShoppingBasket;

		internal Transform Paperbag;

		internal Transform Bankcard;

		internal Transform CashHandy;

		[Header("Boolean Manager")]
		internal bool IsInsideStore;

		internal bool IsGoAway;

		internal bool Arrived;

		internal bool IsItemTaked;

		internal bool IsHoldWaiting;

		internal bool LastStep;

		internal bool FixedEmpty;

		internal bool IsArrivedCashier;

		internal bool FinishShopping;

		internal bool ItsTooLong;

		internal bool CheckpriceOnce;

		internal bool ShouldGo;

		[Header("Floating")]
		internal float TimeFixed;

		internal float WaitingTime;

		internal float IsWaitingTooLong = 5f;

		internal float PriceTotal;

		[Header("Modes")]
		public ModePayement Mode;

		[Header("Information")]
		internal List<ItemInfo> Items = new List<ItemInfo>();

		private void Start()
		{
			ComputerController = UnityEngine.Object.FindObjectOfType<ComputerController>(includeInactive: true);
			Controller = UnityEngine.Object.FindObjectOfType<YelbController>();
			CashRegister = UnityEngine.Object.FindObjectOfType<CashRegister>();
			BOOL = UnityEngine.Object.FindObjectOfType<BooleanManager>();
			Agent = GetComponent<NavMeshAgent>();
			Cold = GetComponent<CapsuleCollider>();
			Anim = GetComponent<Animator>();
			Agent.speed = UnityEngine.Random.Range(1f, 2.5f);
			WaitingTime = UnityEngine.Random.Range(1f, 5f);
			TimeFixed = WaitingTime;
			int num = UnityEngine.Random.Range(0, 3);
			if (num == 2)
			{
				WaitingTime = 0.1f;
			}
			if (num == 0 || num == 1)
			{
				Mode = ModePayement.MasterCard;
			}
			else
			{
				Mode = ModePayement.Cash;
			}
			IsWaitingTooLong += WaitingTime;
			base.transform.position = StartPosition.position;
			Transform[] componentsInChildren = base.transform.GetComponentsInChildren<Transform>(includeInactive: true);
			foreach (Transform transform in componentsInChildren)
			{
				if (transform.name == "Shopping Basket" && ShoppingBasket == null)
				{
					ShoppingBasket = transform;
				}
				if (transform.name == "Bankcard" && Bankcard == null)
				{
					Bankcard = transform;
				}
				if (transform.name == "CashHandy" && CashHandy == null)
				{
					CashHandy = transform;
				}
				if (transform.name == "Paper bag" && Paperbag == null)
				{
					Paperbag = transform;
				}
			}
			CashHandy.gameObject.AddComponent<CardID>();
			Bankcard.gameObject.AddComponent<CardID>();
		}

		private void FixedUpdate()
		{
			if (!ShouldGo)
			{
				if (!ItsTooLong)
				{
					if (!LastStep && !FinishShopping)
					{
						MoveTarget();
					}
					if (FinishShopping)
					{
						Paperbag.GetComponent<MeshRenderer>().enabled = true;
						Paperbag.gameObject.SetActive(value: true);
						ShoppingBasket.gameObject.SetActive(value: false);
						Agent.enabled = true;
						RunAnimation(AnimationModeStart.Walk);
						Anim.SetLayerWeight(1, 1f);
						Agent.SetDestination(EndPosition.position);
						if (Vector3.Distance(base.transform.position, EndPosition.position) < 2f)
						{
							ManagerNPC.TotalItems--;
							UnityEngine.Object.Destroy(base.gameObject);
						}
						Debug.Log("Go out store");
					}
				}
				if (ItsTooLong)
				{
					RunAnimation(AnimationModeStart.Walk);
					Agent.enabled = true;
					Agent.SetDestination(EndPosition.position);
					if (Vector3.Distance(base.transform.position, EndPosition.position) < 2f)
					{
						ManagerNPC.TotalItems--;
						UnityEngine.Object.Destroy(base.gameObject);
					}
				}
			}
			else
			{
				Paperbag.GetComponent<MeshRenderer>().enabled = true;
				Paperbag.gameObject.SetActive(value: true);
				ShoppingBasket.gameObject.SetActive(value: false);
				Agent.enabled = true;
				RunAnimation(AnimationModeStart.Walk);
				Anim.SetLayerWeight(1, 1f);
				Agent.SetDestination(EndPosition.position);
				if (Vector3.Distance(base.transform.position, EndPosition.position) < 2f)
				{
					ManagerNPC.TotalItems--;
					UnityEngine.Object.Destroy(base.gameObject);
				}
			}
		}

		public void MoveTarget()
		{
			if (Vector3.Distance(base.transform.position, Target.position) > 0.5f && !IsGoAway && !Arrived)
			{
				RunAnimation(AnimationModeStart.Walk);
				Agent.SetDestination(Target.position);
				return;
			}
			Arrived = true;
			if (WaitingTime > 0f)
			{
				RunAnimation(AnimationModeStart.Idle);
				Agent.enabled = false;
				Vector3 vector = LookAtWindow.position - base.transform.position;
				Quaternion rotation = Quaternion.LookRotation(new Vector3(vector.x, 0f, vector.z).normalized, Vector3.up);
				base.transform.rotation = rotation;
				WaitingTime -= Time.deltaTime / TimeFixed;
				return;
			}
			Agent.enabled = true;
			if (BOOL == null)
			{
				BOOL = UnityEngine.Object.FindObjectOfType<BooleanManager>(includeInactive: true);
			}
			if (BOOL.IsClosed)
			{
				if (!IsGoAway)
				{
					if (SelectedShelf != null)
					{
						SelectedShelf.IsOnUse = false;
					}
					List<string> information = new List<string>
					{
						"COMBACK LATER SHOP IS CLOSED!"
					};
					Controller.SpawnNotification(information, null);
					IsGoAway = true;
				}
				RunAnimation(AnimationModeStart.Walk);
				Agent.SetDestination(EndPosition.position);
				if (Vector3.Distance(base.transform.position, EndPosition.position) < 2f && IsGoAway)
				{
					ManagerNPC.TotalItems--;
					UnityEngine.Object.Destroy(base.gameObject);
				}
			}
			else
			{
				if (BOOL.IsClosed)
				{
					return;
				}
				if (SelectedShelf == null)
				{
					if (!IsGoAway)
					{
						if (Controller.IsEmptyShop)
						{
							if (!IsGoAway)
							{
								if (SelectedShelf != null)
								{
									SelectedShelf.IsOnUse = false;
								}
								List<string> information2 = new List<string>
								{
									"COMBACK LATER SHOP IS EMPTY!"
								};
								Controller.SpawnNotification(information2, null);
								IsGoAway = true;
							}
							RunAnimation(AnimationModeStart.Walk);
							Agent.SetDestination(EndPosition.position);
							if (Vector3.Distance(base.transform.position, EndPosition.position) < 2f && IsGoAway)
							{
								ManagerNPC.TotalItems--;
								UnityEngine.Object.Destroy(base.gameObject);
							}
							return;
						}
						if (!Controller.IsEmptyShop)
						{
							YelbShelf[] array = UnityEngine.Object.FindObjectsOfType<YelbShelf>();
							if (array.Length != 0)
							{
								int num = 0;
								YelbShelf[] array2 = array;
								for (int i = 0; i < array2.Length; i++)
								{
									if (!array2[i].IsOnUse)
									{
										num++;
									}
								}
								if (num > 0)
								{
									YelbShelf yelbShelf = null;
									int num2 = 0;
									array2 = array;
									foreach (YelbShelf yelbShelf2 in array2)
									{
										if (!yelbShelf2.IsOnUse && yelbShelf2.TotalItems > 0)
										{
											yelbShelf = yelbShelf2;
											num2 = 1;
											break;
										}
									}
									switch (num2)
									{
									case 1:
										yelbShelf.IsOnUse = true;
										SelectedShelf = yelbShelf;
										break;
									case 0:
										if (IsWaitingTooLong > 0f)
										{
											IsWaitingTooLong -= Time.deltaTime;
											break;
										}
										if (SelectedShelf != null)
										{
											SelectedShelf.IsOnUse = false;
										}
										ItsTooLong = true;
										break;
									}
								}
								else
								{
									if (SelectedShelf != null)
									{
										SelectedShelf.IsOnUse = false;
									}
									List<string> information3 = new List<string>
									{
										"STORE ITS FULLED COMBACK LATER"
									};
									Object.FindObjectOfType<YelbController>().SpawnNotification(information3, null);
									IsGoAway = true;
								}
							}
						}
					}
					if (IsGoAway && !Controller.IsEmptyShop)
					{
						if (Controller.IsEmptyShop)
						{
							IsGoAway = false;
						}
						RunAnimation(AnimationModeStart.Walk);
						Agent.SetDestination(EndPosition.position);
						if (Vector3.Distance(base.transform.position, EndPosition.position) < 1f && IsGoAway)
						{
							ManagerNPC.TotalItems--;
							UnityEngine.Object.Destroy(base.gameObject);
						}
					}
					else
					{
						if (!Controller.IsEmptyShop)
						{
							return;
						}
						RunAnimation(AnimationModeStart.Walk);
						if (!IsGoAway)
						{
							if (SelectedShelf != null)
							{
								SelectedShelf.IsOnUse = false;
							}
							List<string> information4 = new List<string>
							{
								"COMBACK LATER SHOP IS EMPTY!"
							};
							Controller.SpawnNotification(information4, null);
							IsGoAway = true;
						}
						if (Vector3.Distance(base.transform.position, EndPosition.position) < 2f && IsGoAway && !FixedEmpty)
						{
							ManagerNPC.TotalItems--;
							UnityEngine.Object.Destroy(base.gameObject);
							FixedEmpty = true;
						}
					}
				}
				else if (!BOOL.IsClosed && !Controller.IsEmptyShop)
				{
					if (!CheckpriceOnce)
					{
						TriggerShelf[] shelfs = SelectedShelf.Shelfs;
						foreach (TriggerShelf triggerShelf in shelfs)
						{
							for (int j = 0; j < triggerShelf.SlotsMenu.Length; j++)
							{
								if (triggerShelf.SlotsMenu[j].childCount > 0 && OriginalPrice(triggerShelf.SlotsMenu[j].GetChild(0).GetComponent<ItemInfo>()) == 0f)
								{
									if (!(triggerShelf.SlotsMenu[j].GetChild(0).GetComponent<ItemInfo>() != null))
									{
										break;
									}
									float priceitem = triggerShelf.SlotsMenu[j].GetChild(0).GetComponent<ItemInfo>().Priceitem;
									float num3 = UnityEngine.Random.Range(priceitem / 2f, priceitem * 2f);
									if (num3 < priceitem || num3 == priceitem)
									{
										break;
									}
									if (SelectedShelf != null)
									{
										SelectedShelf.IsOnUse = false;
									}
									List<string> information5 = new List<string>
									{
										triggerShelf.SlotsMenu[j].GetChild(0).GetComponent<ItemInfo>().ItemName.ToUpper() + " PRICE ITS TOO HIGH FOR ME! NO WAY YOU CAN DO IT HERE"
									};
									Controller.SpawnNotification(information5, null);
									ItsTooLong = true;
									return;
								}
							}
						}
						CheckpriceOnce = true;
					}
					if (!IsHoldWaiting)
					{
						SelectedShelf.IsOnUse = true;
						RunAnimation(AnimationModeStart.Walk);
						Agent.SetDestination(SelectedShelf.PointTarget.position);
						if (Vector3.Distance(base.transform.position, SelectedShelf.PointTarget.position) < 0.2f)
						{
							RunAnimation(AnimationModeStart.Idle);
							StartCoroutine(LoadingAction());
							IsHoldWaiting = true;
						}
					}
				}
				else
				{
					if (!Controller.IsEmptyShop)
					{
						return;
					}
					RunAnimation(AnimationModeStart.Walk);
					if (!IsGoAway)
					{
						if (SelectedShelf != null)
						{
							SelectedShelf.IsOnUse = false;
						}
						List<string> information6 = new List<string>
						{
							"COMBACK LATER SHOP IS EMPTY!"
						};
						Controller.SpawnNotification(information6, null);
						IsGoAway = true;
					}
					if (Vector3.Distance(base.transform.position, EndPosition.position) < 2f && IsGoAway && !FixedEmpty)
					{
						ManagerNPC.TotalItems--;
						UnityEngine.Object.Destroy(base.gameObject);
						FixedEmpty = true;
					}
				}
			}
		}

		public void RunAnimation(AnimationModeStart Mode)
		{
			switch (Mode)
			{
				case AnimationModeStart.Walk:
					YelbBackend.StartAnimation(Anim, "Speed", Agent.velocity.magnitude, AnimationMode.setfloat);
					break;
				case AnimationModeStart.Idle:
					YelbBackend.StartAnimation(Anim, "Speed", 0f, AnimationMode.setfloat);
					break;
				default: 
					Debug.Log("no aniation");
					break;
			}
		}

		public float OriginalPrice(ItemInfo info)
		{
			if (UnityEngine.Random.Range(0, 10) == 1)
			{
				return 0f;
			}
			return 1f;
		}

		private IEnumerator LoadingAction()
		{
			Agent.enabled = false;
			yield return new WaitForEndOfFrame();
			TriggerShelf[] shelfs = SelectedShelf.Shelfs;
			List<TriggerShelf> ActiveShelfs = new List<TriggerShelf>();
			TriggerShelf[] array = shelfs;
			foreach (TriggerShelf triggerShelf in array)
			{
				if (triggerShelf.TotalItems > 0)
				{
					ActiveShelfs.Add(triggerShelf);
				}
			}
			int num = 0;
			foreach (TriggerShelf item in ActiveShelfs)
			{
				num += item.TotalItems;
			}
			if (num > 0)
			{
				int NeededItems = UnityEngine.Random.Range(1, num);
				if (NeededItems > 6)
				{
					NeededItems = UnityEngine.Random.Range(1, 6);
				}
				for (int i = 0; i < NeededItems; i++)
				{
					TriggerShelf ShelfedInfo = null;
					while (ShelfedInfo == null)
					{
						TriggerShelf triggerShelf2 = ActiveShelfs[Random.Range(0, ActiveShelfs.Count)];
						if (triggerShelf2.TotalItems > 0)
						{
							ShelfedInfo = triggerShelf2;
						}
						yield return null;
					}
					Transform[] Slots = ShelfedInfo.SlotsMenu;
					Transform TargetItem = null;
					while (TargetItem == null)
					{
						Transform transform = Slots[Random.Range(0, Slots.Length)];
						if (transform.childCount > 0)
						{
							TargetItem = transform;
						}
						yield return null;
					}
					base.transform.rotation = ShelfedInfo.ShelfData.PointTarget.rotation;
					List<Transform> ChildSlots = new List<Transform>();
					for (int k = 0; k < ShoppingBasket.childCount; k++)
					{
						ChildSlots.Add(ShoppingBasket.GetChild(k));
					}
					string text = SelectedShelf.name.ToLower();
					if (text.Contains("freezer"))
					{
						Anim.Play("LowPick");
						float animationDuration4 = Anim.GetCurrentAnimatorClipInfo(0)[0].clip.length;
						if (NeededItems > 1 && i != NeededItems - 1)
						{
							animationDuration4 -= 3.7f;
						}
						yield return new WaitForSeconds(1f);
						Paperbag.gameObject.SetActive(value: true);
						Paperbag.GetComponent<MeshRenderer>().enabled = false;
						Transform Item4 = TargetItem.transform.GetChild(0).transform;
						Item4.SetParent(Paperbag.transform);
						Item4.localPosition = Vector3.zero;
						Item4.localEulerAngles = Vector3.zero;
						Items.Add(Item4.GetComponent<ItemInfo>());
						yield return new WaitForSeconds(animationDuration4 / 2f);
						foreach (Transform item2 in ChildSlots)
						{
							if (item2.childCount == 0)
							{
								Item4.SetParent(item2);
								Item4.localPosition = Vector3.zero;
								Item4.localEulerAngles = Vector3.zero;
								Item4.localScale = Vector3.one;
							}
						}
						yield return new WaitForSeconds(animationDuration4 / 2f);
						ShelfedInfo.TakeItem(TargetItem);
					}
					else if (text.Contains("shelf") || text.Contains("fridge"))
					{
						float y = GetComponent<CapsuleCollider>().bounds.center.y;
						float num2 = 0.1f;
						if (TargetItem.position.y > y + num2)
						{
							Anim.Play("HighPick");
							float animationDuration4 = Anim.GetCurrentAnimatorClipInfo(0)[0].clip.length;
							if (NeededItems > 1 && i != NeededItems - 1)
							{
								animationDuration4 -= 3.7f;
							}
							yield return new WaitForSeconds(1f);
							Paperbag.gameObject.SetActive(value: true);
							Paperbag.GetComponent<MeshRenderer>().enabled = false;
							Transform Item4 = TargetItem.transform.GetChild(0).transform;
							Item4.SetParent(Paperbag.transform);
							Item4.localPosition = Vector3.zero;
							Item4.localEulerAngles = Vector3.zero;
							Items.Add(Item4.GetComponent<ItemInfo>());
							yield return new WaitForSeconds(1.2f);
							foreach (Transform item3 in ChildSlots)
							{
								if (item3.childCount == 0)
								{
									Item4.SetParent(item3);
									Item4.localPosition = Vector3.zero;
									Item4.localEulerAngles = Vector3.zero;
									Item4.localScale = Vector3.one;
								}
							}
							yield return new WaitForSeconds(animationDuration4 / 2f);
							ShelfedInfo.TakeItem(TargetItem);
						}
						else if (TargetItem.position.y < y - num2)
						{
							Anim.Play("LowPick");
							float animationDuration4 = Anim.GetCurrentAnimatorClipInfo(0)[0].clip.length;
							if (NeededItems > 1 && i != NeededItems - 1)
							{
								animationDuration4 -= 3.7f;
							}
							yield return new WaitForSeconds(1f);
							Paperbag.gameObject.SetActive(value: true);
							Paperbag.GetComponent<MeshRenderer>().enabled = false;
							Transform Item4 = TargetItem.transform.GetChild(0).transform;
							Item4.SetParent(Paperbag.transform);
							Item4.localPosition = Vector3.zero;
							Item4.localEulerAngles = Vector3.zero;
							Items.Add(Item4.GetComponent<ItemInfo>());
							yield return new WaitForSeconds(animationDuration4 / 2f);
							foreach (Transform item4 in ChildSlots)
							{
								if (item4.childCount == 0)
								{
									Item4.SetParent(item4);
									Item4.localPosition = Vector3.zero;
									Item4.localEulerAngles = Vector3.zero;
									Item4.localScale = Vector3.one;
								}
							}
							yield return new WaitForSeconds(animationDuration4 / 2f);
							ShelfedInfo.TakeItem(TargetItem);
						}
						else
						{
							Anim.Play("MiddlePick");
							float animationDuration4 = Anim.GetCurrentAnimatorClipInfo(0)[0].clip.length;
							if (NeededItems > 1 && i != NeededItems - 1)
							{
								animationDuration4 -= 3.7f;
							}
							yield return new WaitForSeconds(1f);
							Paperbag.gameObject.SetActive(value: true);
							Paperbag.GetComponent<MeshRenderer>().enabled = false;
							Transform Item4 = TargetItem.transform.GetChild(0).transform;
							Item4.SetParent(Paperbag.transform);
							Item4.localPosition = Vector3.zero;
							Item4.localEulerAngles = Vector3.zero;
							Items.Add(Item4.GetComponent<ItemInfo>());
							yield return new WaitForSeconds(animationDuration4 / 2f);
							foreach (Transform item5 in ChildSlots)
							{
								if (item5.childCount == 0)
								{
									Item4.SetParent(item5);
									Item4.localPosition = Vector3.zero;
									Item4.localEulerAngles = Vector3.zero;
									Item4.localScale = Vector3.one;
								}
							}
							yield return new WaitForSeconds(animationDuration4 / 2f);
							ShelfedInfo.TakeItem(TargetItem);
						}
					}
					yield return null;
				}
			}
			yield return new WaitForEndOfFrame();
			StartCoroutine(GoToPose());
		}

		private IEnumerator GoToPose()
		{
			SelectedShelf.IsOnUse = false;
			LastStep = true;
			ManagerNPC.LimitCharacter++;
			ManagerNPC.RandomTotalBuyers++;
			SelectedShelf.IsOnUse = false;
			Agent.enabled = true;
			Transform Zone = PayingZone;
			SideCashier sideCashier = null;
			SideCashier[] array = UnityEngine.Object.FindObjectsOfType<SideCashier>();
			if (array.Length != 0)
			{
				sideCashier = array[Random.Range(0, array.Length)];
			}
			if (sideCashier != null)
			{
				int totalClients = CashRegister.TotalClients;
				int totalClients2 = sideCashier.TotalClients;
				if (totalClients > totalClients2)
				{
					Zone = sideCashier.ArrivePoint;
					sideCashier.Clients.Add(base.transform);
					sideCashier.TotalClients++;
				}
				if (totalClients < totalClients2)
				{
					Zone = PayingZone;
					CashRegister.Clients.Add(base.transform);
					CashRegister.TotalClients++;
				}
				if (totalClients == totalClients2)
				{
					int num = UnityEngine.Random.Range(0, 2);
					if (num == 0 || num == 1)
					{
						Zone = PayingZone;
						CashRegister.Clients.Add(base.transform);
						CashRegister.TotalClients++;
					}
					else
					{
						Zone = sideCashier.ArrivePoint;
						sideCashier.Clients.Add(base.transform);
						sideCashier.TotalClients++;
					}
				}
			}
			else
			{
				CashRegister.Clients.Add(base.transform);
				CashRegister.TotalClients++;
			}
			if (Zone.GetComponent<CashPositionIndex>() == null)
			{
				Zone.gameObject.AddComponent<CashPositionIndex>();
			}
			CashPositionIndex cashPositionIndex = Zone.GetComponent<CashPositionIndex>();
			bool IsArrived = false;
			while (!IsArrived)
			{
				if (!cashPositionIndex.ListNPC.Contains(base.gameObject))
				{
					cashPositionIndex.ListNPC.Add(base.gameObject);
				}
				Vector3 vector = Zone.position;
				if (cashPositionIndex.ListNPC.IndexOf(base.gameObject) > 0)
				{
					vector += (float)cashPositionIndex.ListNPC.IndexOf(base.gameObject) * -0.5f * Zone.forward;
				}
				if (Vector3.Distance(base.transform.position, vector) < 0.1f)
				{
					IsArrived = true;
				}
				RunAnimation(AnimationModeStart.Walk);
				Agent.SetDestination(vector);
				yield return null;
			}
			if (IsArrived)
			{
				Agent.enabled = false;
				RunAnimation(AnimationModeStart.Idle);
				base.transform.rotation = Zone.rotation;
				StartCoroutine(ControllerShopSystem());
			}
		}

		private IEnumerator ControllerShopSystem()
		{
			IsArrivedCashier = true;
			yield return new WaitForEndOfFrame();
		}

		private void OnTriggerEnter(Collider other)
		{
			if (other.name == "Basket Pick" && !FinishShopping)
			{
				GameObject.Find("SoundEnterdNPC").GetComponent<AudioSource>().Play();
				if (!ShoppingBasket.gameObject.activeSelf)
				{
					ShoppingBasket.gameObject.SetActive(value: true);
				}
			}
		}
	}

	[Header("Transform")]
	public Transform[] PointSpawn;

	public Transform[] TargetWayPoint;

	public Transform LookAtIdle;

	public Transform PayingZone;

	[Header("List NPC")]
	public GameObject[] LISTNPC;

	[Header("Integer")]
	internal int RandomTotalBuyers = 1;

	internal int TotalItems;

	internal int LimitCharacter = 7;

	[Header("Floating Manager")]
	internal float TimeBtw = 5f;

	[Header("Information")]
	internal List<NPC> nPCs = new List<NPC>();

	private void Start()
	{
		TotalItems = nPCs.Count;
	}

	private void Update()
	{
		if (TotalItems >= LimitCharacter)
		{
			return;
		}
		if (TotalItems < RandomTotalBuyers)
		{
			Transform transform = PointSpawn[Random.Range(0, PointSpawn.Length)];
			Transform target = TargetWayPoint[Random.Range(0, TargetWayPoint.Length)];
			Transform endPosition = null;
			Transform[] pointSpawn = PointSpawn;
			foreach (Transform transform2 in pointSpawn)
			{
				if (transform2 != transform)
				{
					endPosition = transform2;
				}
			}
			GameObject gameObject = UnityEngine.Object.Instantiate(LISTNPC[Random.Range(0, LISTNPC.Length)]);
			NPC nPC = gameObject.AddComponent<NPC>();
			nPC.Target = target;
			nPC.StartPosition = transform;
			nPC.EndPosition = endPosition;
			nPC.LookAtWindow = LookAtIdle;
			nPC.PayingZone = PayingZone;
			nPC.ManagerNPC = this;
			gameObject.SetActive(value: true);
			TimeBtw = UnityEngine.Random.Range(7, 17);
			TotalItems++;
		}
		else if (TimeBtw > 0f)
		{
			TimeBtw -= Time.deltaTime;
		}
		else
		{
			RandomTotalBuyers++;
		}
	}
}
