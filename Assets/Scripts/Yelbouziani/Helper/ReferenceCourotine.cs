// DecompilerFi decompiler from Assembly-CSharp.dll class: Yelbouziani.Helper.ReferenceCourotine
using System.Collections;
using UnityEngine;

namespace Yelbouziani.Helper
{
	public class ReferenceCourotine : MonoBehaviour
	{
		[Header("Floating")]
		public float TimeTake;

		public IEnumerator ActionTake(GameObject OBJ)
		{
			yield return new WaitForSeconds(TimeTake);
			UnityEngine.Object.Destroy(OBJ);
			yield return new WaitForEndOfFrame();
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}
}
