// DecompilerFi decompiler from Assembly-CSharp.dll class: ShopItem
using System;
using UnityEngine;

[Serializable]
public class ShopItem
{
	[Header("Strings")]
	public string NameItem = "";

	public string DescriptionItem = "";

	[Header("Floating")]
	public float PriceItem;

	[Header("Integer")]
	public int Level = 1;

	[Header("OBJ")]
	public GameObject OBJ;

	[Header("UI")]
	public Sprite ImageIcon;

	[Header("Boolean Manager")]
	public bool AddToBasket;

	public bool IsBigBox;

	public bool ShouldPlaceInside;
}
