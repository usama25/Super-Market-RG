// DecompilerFi decompiler from Assembly-CSharp.dll class: Yelbouziani.Helper.CameraTrigger
using UnityEngine;

namespace Yelbouziani.Helper
{
	public class CameraTrigger : MonoBehaviour
	{
		public Vector3 AvoidePoint = Vector3.zero;

		private void Start()
		{
			base.gameObject.AddComponent<SphereCollider>().isTrigger = true;
			base.gameObject.AddComponent<Rigidbody>().isKinematic = true;
		}

		private void OnCollisionExit(Collision collision)
		{
			AvoidePoint = Vector3.zero;
		}

		private void OnTriggerExit(Collider other)
		{
			AvoidePoint = Vector3.zero;
		}

		private void OnCollisionEnter(Collision collision)
		{
			AvoidePoint = collision.impulse;
		}

		private void OnTriggerEnter(Collider other)
		{
			AvoidePoint = other.ClosestPoint(base.transform.position);
		}
	}
}
