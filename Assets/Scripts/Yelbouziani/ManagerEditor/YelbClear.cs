// DecompilerFi decompiler from Assembly-CSharp.dll class: Yelbouziani.ManagerEditor.YelbClear
using UnityEngine;

namespace Yelbouziani.ManagerEditor
{
	public class YelbClear
	{
		public static void ClearController(GameObject gameObject)
		{
			string[] array = new string[1]
			{
				"CF2"
			};
			int num = 0;
			while (true)
			{
				if (num < array.Length)
				{
					if (gameObject.name.Contains(array[num]))
					{
						break;
					}
					num++;
					continue;
				}
				return;
			}
			string text2 = gameObject.name = gameObject.name.Replace(array[num], "Yelb");
		}
	}
}
