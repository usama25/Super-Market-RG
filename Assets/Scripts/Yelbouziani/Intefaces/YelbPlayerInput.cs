// DecompilerFi decompiler from Assembly-CSharp.dll class: Yelbouziani.Intefaces.YelbPlayerInput
using UnityEngine;

namespace Yelbouziani.Intefaces
{
	public interface YelbPlayerInput
	{
		void Jump(int force);

		void ChangeGun(string GunID, GameObject GunObject);

		void ReloadAmmo();

		void ShootBullet(bool Status);
	}
}
