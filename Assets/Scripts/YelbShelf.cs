// DecompilerFi decompiler from Assembly-CSharp.dll class: YelbShelf
using UnityEngine;

public class YelbShelf : MonoBehaviour
{
	[Header("Manager")]
	public TriggerShelf[] Shelfs;

	[Header("Transform")]
	public Transform PointTarget;

	[Header("Integer")]
	internal int TotalItems;

	[Header("Boolean Manager")]
	internal bool IsOnUse;

	private void Awake()
	{
		TriggerShelf[] shelfs = Shelfs;
		for (int i = 0; i < shelfs.Length; i++)
		{
			shelfs[i].ShelfData = this;
		}
		Init();
	}

	private void Init()
	{
		for (int i = 0; i < Shelfs.Length; i++)
		{
			Transform transform = Shelfs[i].transform.Find("PriceBG");
			SetPrice setPrice = transform.GetComponent<SetPrice>();
			if (setPrice == null)
			{
				setPrice = transform.gameObject.AddComponent<SetPrice>();
			}
			Transform[] componentsInChildren = Shelfs[i].transform.GetComponentsInChildren<Transform>();
			foreach (Transform transform2 in componentsInChildren)
			{
				if (transform2.name == "PriceTag")
				{
					SetPrice setPrice2 = transform2.GetComponent<SetPrice>();
					if (setPrice2 == null)
					{
						setPrice2 = transform2.gameObject.AddComponent<SetPrice>();
					}
					setPrice2.Shelf = Shelfs[i];
				}
			}
			setPrice.Shelf = Shelfs[i];
		}
	}

	public void ActivateTrigger(TriggerShelf shelf)
	{
		TriggerShelf[] shelfs = Shelfs;
		foreach (TriggerShelf triggerShelf in shelfs)
		{
			if (triggerShelf.ToggleShelf.gameObject.activeSelf && triggerShelf != shelf)
			{
				triggerShelf.ToggleShelf.SetActive(value: false);
			}
		}
		shelf.ToggleShelf.SetActive(value: true);
	}
}
