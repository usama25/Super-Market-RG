// DecompilerFi decompiler from Assembly-CSharp.dll class: CashRegister
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CashRegister : MonoBehaviour
{
	[Header("Manager")]
	internal BooleanManager BOOL;

	[Header("Boolean Manager")]
	public bool IsLocked;

	[Header("Transform")]
	public Transform FlyOut;

	public Transform UsingCharacter;

	public Transform FacePosition;

	public Transform ContainerItems;

	public Transform BankInput;

	public Transform CameraReference;

	[Header("List")]
	public Transform[] Slots;

	public Transform[] EndSlots;

	[Header("Manager")]
	public YelbCharacter CharacterManager;

	[Header("Text")]
	public Text PriceTotal;

	[Header("Integer")]
	internal int TotalClients;

	internal int TotalItemScane;

	[Header("Boolean Manager")]
	public bool IsBussy;

	[Header("Clients")]
	public List<Transform> Clients = new List<Transform>();

	public List<Transform> CashItems = new List<Transform>();

	[Header("Flaot")]
	public Vector3 Offset;

	private void Start()
	{
		BOOL = UnityEngine.Object.FindObjectOfType<BooleanManager>();
	}

	private void Update()
	{
		if (IsLocked)
		{
			CharacterManager._Controller.enabled = false;
			CharacterManager.transform.position = new Vector3(FlyOut.transform.position.x, FlyOut.transform.position.x, FlyOut.transform.position.z) - Offset;
			if (!IsBussy)
			{
				ManagerLogic();
			}
		}
	}

	public void ManagerLogic()
	{
		Debug.Log("Manager Logic");
		if (TotalClients > 0 && UsingCharacter == null)
		{
			for (int num = Clients.Count - 1; num >= 0; num--)
			{
				if (Clients[num] == null)
				{
					Clients.RemoveAt(num);
				}
			}
			Debug.Log("Set up : " + Clients[0]);
			UsingCharacter = Clients[0];
		}
		if (UsingCharacter != null)
		{
			YelbNPC.NPC component = UsingCharacter.GetComponent<YelbNPC.NPC>();
			if (component != null && component.IsArrivedCashier)
			{
				StartCoroutine(StartManagementClient(component));
				Debug.Log("Busy with : " + component);
				IsBussy = true;
			}
		}
	}

	public void MoveItemToScan(ItemInfo Info)
	{
		StartCoroutine(MoveItem(Info));
	}

	public void CLearMacina()
	{
		for (int i = 1; i < ContainerItems.childCount; i++)
		{
			UnityEngine.Object.Destroy(ContainerItems.GetChild(i).gameObject);
		}
		PriceTotal.text = "0$";
	}

	public void removeClient(YelbNPC.NPC NPC)
	{
		//if (Clients.Count <= 0)
		//return;

		//NPC.gameObject.SetActive(false);
		NPC.ShouldGo = false;
		NPC.ItsTooLong = false;
		NPC.FinishShopping = true;
		NPC.IsGoAway = true;
		NPC.Anim.Play("Movement");
		TotalClients--;
		TotalItemScane = 0;
		CLearMacina();
		CashItems.Clear();
		Clients.RemoveAt(0);
		UsingCharacter = null;
		IsBussy = false;
	}

	private IEnumerator MoveItem(ItemInfo Info)
	{
		YelbNPC.NPC NPC = UsingCharacter.GetComponent<YelbNPC.NPC>();
		Transform Target = EndSlots[Random.Range(0, EndSlots.Length)];
		Transform Item = Info.transform;
		float TimeLaps = 0f;
		while (TimeLaps < 1f)
		{
			if (Vector3.Distance(Item.position, Target.position) < 0.1f)
			{
				TimeLaps = 1f;
			}
			Item.position = Vector3.Lerp(Item.position, Target.position, TimeLaps);
			TimeLaps += Time.deltaTime / 2f;
			yield return null;
		}
		GameObject gameObject = UnityEngine.Object.Instantiate(ContainerItems.GetChild(0).gameObject);
		gameObject.transform.GetChild(0).GetComponent<Text>().text = Info.ItemName;
		gameObject.transform.GetChild(1).GetComponent<Text>().text = Info.Priceitem.ToString() + "$";
		gameObject.transform.SetParent(ContainerItems);
		gameObject.transform.localScale = Vector3.one;
		gameObject.GetComponent<RectTransform>().sizeDelta = ContainerItems.GetChild(0).GetComponent<RectTransform>().sizeDelta;
		gameObject.GetComponent<RectTransform>().anchoredPosition = ContainerItems.GetChild(0).GetComponent<RectTransform>().anchoredPosition;
		gameObject.transform.localRotation = Quaternion.identity;
		gameObject.transform.localPosition = Vector3.zero;
		gameObject.SetActive(value: true);
		Info.transform.parent = null;
		UsingCharacter.GetComponent<YelbNPC.NPC>().PriceTotal += Info.Priceitem;
		PriceTotal.text = UsingCharacter.GetComponent<YelbNPC.NPC>().PriceTotal.ToString() + "$";
		yield return new WaitForEndOfFrame();
		CashItems.Add(Item);
		bool flag = false;
		for (int i = 0; i < Slots.Length; i++)
		{
			if (Slots[i].childCount > 0)
			{
				flag = true;
			}
		}
		if (!flag)
		{
			switch (NPC.Mode)
			{
			case ModePayement.MasterCard:
				NPC.Bankcard.gameObject.SetActive(value: true);
				NPC.Anim.Play("HoldCard");
				break;
			case ModePayement.Cash:
				NPC.CashHandy.gameObject.SetActive(value: true);
				NPC.Anim.Play("HoldCard");
				break;
			}
			BOOL.IsCheckingMethode = true;
		}
	}

	public IEnumerator StartManagementClient(YelbNPC.NPC NPC)
	{
		NPC.Agent.enabled = false;
		NPC.ShoppingBasket.gameObject.SetActive(value: false);
		Transform TransformNPC = NPC.transform;
		float ValueSmooth = 0f;
		while (ValueSmooth < 1f)
		{
			if (Vector3.Distance(TransformNPC.position, FacePosition.position) < 0.2f)
			{
				ValueSmooth = 1f;
			}
			TransformNPC.position = Vector3.Lerp(TransformNPC.position, FacePosition.position, ValueSmooth);
			ValueSmooth += Time.deltaTime / 2f;
			yield return null;
		}
		NPC.Anim.Play("MiddlePick");
		yield return new WaitForSeconds(1.5f);
		List<ItemInfo> Items = NPC.Items;
		for (int i = 0; i < Items.Count; i++)
		{
			yield return new WaitForSeconds(0.2f);
			ItemInfo itemInfo = Items[i];
			itemInfo.transform.SetParent(Slots[i].transform);
			itemInfo.transform.localPosition = Vector3.zero;
			itemInfo.transform.localEulerAngles = Vector3.zero;
			itemInfo.transform.localScale = Vector3.one;
			TotalItemScane++;
		}
		yield return new WaitForEndOfFrame();
		BOOL.IsBusyWithItems = true;
	}
}
