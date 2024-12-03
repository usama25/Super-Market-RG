// DecompilerFi decompiler from Assembly-CSharp.dll class: Yelbouziani.Helper.RemoveObject
using System.Collections.Generic;
using UnityEngine;

namespace Yelbouziani.Helper
{
	public class RemoveObject : MonoBehaviour
	{
		public List<BoxCollider> colliders = new List<BoxCollider>();

		public List<int> ModeTrigger = new List<int>();

		public GameObject HolderObject;
	}
}
