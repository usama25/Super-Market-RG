// DecompilerFi decompiler from Assembly-CSharp.dll class: SideCashier
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Yelbouziani;

public class SideCashier : MonoBehaviour
{
	[Header("Manager")]
	internal YelbController _YelbController;

	[Header("Transform")]
	public Transform ArrivePoint;

	public Transform UsingCharacter;

	[Header("List")]
	public Transform[] Slots;

	[Header("Animator")]
	public Animator _anim;

	[Header("Integer")]
	internal int TotalClients;

	[Header("Clients")]
	internal List<Transform> Clients = new List<Transform>();

	[Header("Boolean Manager")]
	internal bool IsBusy;

	private void Awake()
	{
		_YelbController = UnityEngine.Object.FindObjectOfType<YelbController>();
	}

	private void LateUpdate()
	{
		if (IsBusy)
		{
			return;
		}
		if (Clients.Count > 0 && UsingCharacter == null)
		{
			for (int num = Clients.Count - 1; num >= 0; num--)
			{
				if (Clients[num] == null)
				{
					Clients.RemoveAt(num);
				}
			}
			UsingCharacter = Clients[0];
		}
		if (UsingCharacter != null)
		{
			YelbNPC.NPC component = UsingCharacter.GetComponent<YelbNPC.NPC>();
			if (component.IsArrivedCashier)
			{
				StartCoroutine(LoadingActionShop(component));
				IsBusy = true;
			}
		}
	}

	private IEnumerator LoadingActionShop(YelbNPC.NPC NPC)
	{
		List<ItemInfo> Items = NPC.Items;
		float TotalPrice = 0f;
		for (int i = 0; i < Items.Count; i++)
		{
			_anim.Play("Scan");
			yield return new WaitForSeconds(0.8f);
			ItemInfo itemInfo = Items[i];
			itemInfo.transform.SetParent(Slots[i].transform);
			itemInfo.transform.localPosition = Vector3.zero;
			itemInfo.transform.localEulerAngles = Vector3.zero;
			itemInfo.transform.localScale = Vector3.one;
			float priceitem = itemInfo.Priceitem;
			string itemName = itemInfo.ItemName;
			Sprite iconItem = itemInfo.IconItem;
			TotalPrice += priceitem;
			yield return new WaitForSeconds(0.2f);
		}
		yield return new WaitForSeconds(0.5f);
		foreach (ItemInfo item in Items)
		{
			item.gameObject.SetActive(value: false);
		}
		List<string> information = new List<string>
		{
			"EMPLOYEE SOLD: $" + TotalPrice.ToString()
		};
		_YelbController.SpawnNotification(information, null);
		PlayerPrefs.SetFloat(YelbRef.CashValue, YelbBackend.GetValueFromFloat(YelbRef.CashValue) + TotalPrice);
		yield return new WaitForEndOfFrame();
		NPC.FinishShopping = true;
		IsBusy = false;
		Clients.Remove(NPC.gameObject.transform);
		UsingCharacter = null;
		_anim.Play("Idle");
	}
}
