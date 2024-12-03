// DecompilerFi decompiler from Assembly-CSharp.dll class: Yelbouziani.Intefaces.YelbManagement
using UnityEngine;

namespace Yelbouziani.Intefaces
{
	public interface YelbManagement
	{
		void Interact(Transform Pre);

		void Destroy();

		void TakeItem();

		void TakeAction();

		void AttackHealth(float ValueTake);
	}
}
