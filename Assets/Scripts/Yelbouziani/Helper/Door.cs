// DecompilerFi decompiler from Assembly-CSharp.dll class: Yelbouziani.Helper.Door
using System.Collections;
using UnityEngine;

namespace Yelbouziani.Helper
{
	public class Door : MonoBehaviour
	{
		public bool opened = true;
		public bool IsInisilized;

		[Header("Floating")]
		internal float TargetRotation;

		private void Start()
		{
			TargetRotation = (base.name.ToLower().Contains("+") ? 90f : (-90f));
			if (base.name == "DoorOpener")
			{
				TargetRotation = 180f;
			}
		}

		public void CheckDoor()
		{
			if (base.gameObject.name != "dooropen")
			{
				StartCoroutine(LoadingDoor(Status: true));
				base.gameObject.name = "dooropen";
			}
			else
			{
				StartCoroutine(LoadingDoor(Status: false));
				base.gameObject.name = "doorclose";
			}
		}

		public IEnumerator LoadingDoor(bool Status)
		{
			Quaternion startRotation = base.transform.localRotation;
			Quaternion endRotation = Quaternion.Euler(base.transform.localEulerAngles.x, 
				base.transform.localEulerAngles.y + (Status ? TargetRotation : (0f - TargetRotation)),
				base.transform.localEulerAngles.z);
			//float targetAngle = isOpen ? targetRotation : 0f;
			//endRotation = Quaternion.Euler(transform.localEulerAngles.x, transform.localEulerAngles.y + targetAngle, transform.localEulerAngles.z);
			if (base.transform.childCount > 0)
			{
				if (base.transform.GetChild(0).name == "CloseStatus")
				{
					GameObject.Find("Crafting Metallic item 5").GetComponent<AudioSource>().Play();
					Object.FindObjectOfType<BooleanManager>().IsClosed = !Status;
				}
				else
				{
					if (!Status)
					{
						GameObject.Find("doorCloseSound").GetComponent<AudioSource>().Play();
					}
					if (Status)
					{
						GameObject.Find("openDoorSound").GetComponent<AudioSource>().Play();
					}
				}
			}
			float duration = 0.7f;
			float elapsed = 0f;
			while (elapsed < duration)
			{
				elapsed += Time.deltaTime;
				float t = Mathf.Clamp01(elapsed / duration);
				//base.transform.localRotation = Quaternion.Lerp(startRotation, endRotation, t);
				
				base.transform.localRotation = endRotation;
				yield return null;
			}
			base.transform.localRotation = endRotation;
		}
	}
}
