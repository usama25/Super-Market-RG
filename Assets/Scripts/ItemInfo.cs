// DecompilerFi decompiler from Assembly-CSharp.dll class: ItemInfo
using UnityEngine;

public class ItemInfo : MonoBehaviour
{
	[Header("Floating")]
	public float Priceitem;

	[Header("Strings")]
	public string ItemName = "";

	public string IDInstance = "";

	[Header("Sprites")]
	public Sprite IconItem;

	private void Start()
	{
		if (GetComponent<Collider>() == null)
		{
			base.gameObject.AddComponent<BoxCollider>();
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.name == "ScanTrigger")
		{
			GameObject.Find("etfx_explosion_scan").GetComponent<AudioSource>().Play();
			if (GetComponent<Rigidbody>() == null)
			{
				base.gameObject.AddComponent<Rigidbody>();
			}
		}
	}
}
