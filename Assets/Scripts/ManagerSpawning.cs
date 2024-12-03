// DecompilerFi decompiler from Assembly-CSharp.dll class: ManagerSpawning
using System;
using UnityEngine;

[Serializable]
public class ManagerSpawning : MonoBehaviour
{
	[Header("Object")]
	internal GameObject ModelYelb;

	[Header("Integer")]
	internal int ItemsToSpawn;

	[Header("Strings")]
	internal string NameItem = "";

	[Header("Floating Manager")]
	internal float PriceValue;

	[Header("Boolean Manager")]
	internal bool IsBigBox;

	internal bool ShouldPlaceInside;

	[Header("Sprite")]
	internal Sprite IconItem;
}
