// DecompilerFi decompiler from Assembly-CSharp.dll class: Yelbouziani.YelbBackend
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.Networking;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using Yelbouziani.Enum;
using Yelbouziani.Helper;

namespace Yelbouziani
{
	public class YelbBackend : MonoBehaviour
	{
		internal const string SoundID = "YelbSound";

		internal const string MusicId = "YelbMusic";

		internal const string Effectid = "YelbEffect";

		internal const string LevelId = "LevelInformation";

		internal const string TimeData = "TimeTravel";

		internal const string ModeGameLauncher = "YelbLauncher";

		public static List<string> ListYears(int startYear, int endYear)
		{
			List<string> list = new List<string>();
			for (int i = startYear; i <= endYear; i++)
			{
				list.Add(i.ToString());
			}
			return list;
		}

		public static List<string> ListMonths()
		{
			List<string> list = new List<string>();
			for (int i = 1; i <= 12; i++)
			{
				string monthName = DateTimeFormatInfo.CurrentInfo.GetMonthName(i);
				list.Add(monthName);
			}
			return list;
		}

		public static List<string> ListDays(string monthName)
		{
			List<string> list = new List<string>();
			int num = Array.IndexOf(DateTimeFormatInfo.CurrentInfo.MonthNames, monthName);
			if (num < 0)
			{
				throw new ArgumentException("Invalid month name");
			}
			int num2 = DateTime.DaysInMonth(DateTime.Now.Year, num + 1);
			for (int i = 1; i <= num2; i++)
			{
				list.Add(i.ToString());
			}
			return list;
		}

		public static string GetDaysOfWeekAsString(int daysInMonth)
		{
			StringBuilder stringBuilder = new StringBuilder();
			int num = (int)(DateTime.Now.DayOfWeek + 6) % 7 + 1;
			stringBuilder.Append(GetDayNameByNumber(num));
			for (int i = 1; i < daysInMonth; i++)
			{
				int dayNumber = (num + i - 1) % 7 + 1;
				stringBuilder.Append(", ").Append(GetDayNameByNumber(dayNumber));
			}
			return stringBuilder.ToString();
		}

		public static string GetDayNameByNumber(int dayNumber)
		{
			return ((DayOfWeek)((dayNumber - 1 + 7) % 7)).ToString();
		}

		public static List<string> DataItemsScene()
		{
			List<string> result = new List<string>();
			string path = "data.json";
			string path2 = Path.Combine(Application.dataPath, "Resources", path);
			if (File.Exists(path2))
			{
				File.ReadAllText(path2);
			}
			return result;
		}

		public static void SaveDataScene(GameObject[] ListObject)
		{
			string path = "data.json";
			string path2 = Path.Combine(Application.dataPath, "Resources", path);
			if (!File.Exists(path2))
			{
				string contents = "{\"name\": \"John Doe\", \"age\": 30}";
				File.WriteAllText(path2, contents);
			}
			else
			{
				string text = File.ReadAllText(path2);
				text = text.Replace("John Doe", "Jane Doe");
				File.WriteAllText(path2, text);
			}
		}

		public static Vector3 StringToVector3(string s)
		{
			s = s.Replace("(", "").Replace(")", "");
			string[] array = s.Split(',');
			//Debug.Log("StringToVector3 : " + array);
			if (array.Length == 3)
			{
				float x = float.Parse(array[0], System.Globalization.CultureInfo.InvariantCulture);
				//Debug.Log("array[0]  : " + array[0]);
				//Debug.Log("x  : " + x);
				float y = float.Parse(array[1], System.Globalization.CultureInfo.InvariantCulture);
				float z = float.Parse(array[2], System.Globalization.CultureInfo.InvariantCulture);
				return new Vector3(x, y, z);
			}
			UnityEngine.Debug.LogError("Invalid Vector3 string: " + s);
			return Vector3.zero;
		}

		public static Vector3 InputAxis(ModeSelection ModeInput)
		{
			switch (ModeInput)
			{
			case ModeSelection.movement:
				return new Vector3(SimpleInput.GetAxis("Horizontal"), SimpleInput.GetAxis("Vertical"), SimpleInput.GetAxis("Depth"));
			case ModeSelection.rotation:
				return new Vector3(SimpleInput.GetAxis("RotationX"), SimpleInput.GetAxis("RotationY"), SimpleInput.GetAxis("Depth"));
			default:
				return Vector3.zero;
			}
		}

		public static Vector3 DirectionMovingCharacterController(CharacterController controller, Transform DirectionCamera, float speedMovement)
		{
			Vector3 vector = InputAxis(ModeSelection.movement);
			Vector3 zero = Vector3.zero;
			if (vector != Vector3.zero)
			{
				Vector3 forward = DirectionCamera.forward;
				forward.y = 0f;
				forward.Normalize();
				zero = (forward * vector.y + DirectionCamera.right * vector.x).normalized * speedMovement;
				controller.Move(zero * Time.deltaTime);
				IsObstacleFacing(DirectionCamera);
				if (!controller.isGrounded)
				{
					Vector3 motion = Physics.gravity * Time.deltaTime;
					controller.Move(motion);
				}
			}
			else if (!controller.isGrounded)
			{
				Vector3 motion2 = Physics.gravity * Time.deltaTime;
				controller.Move(motion2);
			}
			return Vector3.zero;
		}

		public static Vector3 DirectionMovingRigidbody(Rigidbody rb, Transform directionPlayer, float speedMovement)
		{
			Vector3 vector = InputAxis(ModeSelection.movement);
			if (vector != Vector3.zero)
			{
				float y = Mathf.Atan2(vector.x, vector.y) * 57.29578f;
				Quaternion b = Quaternion.Euler(0f, y, 0f);
				directionPlayer.rotation = Quaternion.Slerp(directionPlayer.rotation, b, Time.deltaTime * speedMovement);
				Vector3 vector2 = directionPlayer.forward * speedMovement;
				Vector3 b2 = new Vector3(0f, -5f, 0f);
				rb.velocity = vector2;
				IsObstacleFacing(directionPlayer);
				rb.isKinematic = false;
				if (!IsGrounded(directionPlayer))
				{
					rb.velocity = vector2 + b2;
				}
			}
			else if (IsGrounded(directionPlayer))
			{
				rb.velocity = Vector3.zero;
				rb.isKinematic = true;
			}
			else
			{
				rb.velocity = Vector3.zero + new Vector3(0f, -5f, 0f);
			}
			return Vector3.zero;
		}

		public static Quaternion RotationTarget(Vector3 Direction)
		{
			return Quaternion.identity;
		}

		public static Vector3 CalculateTargetPosition(Transform obstacle)
		{
			Vector3 vector = obstacle.position;
			if (obstacle.forward == Vector3.forward)
			{
				vector += Vector3.right * 10f;
			}
			else if (obstacle.forward == -Vector3.forward)
			{
				vector -= Vector3.right * 10f;
			}
			else if (obstacle.forward == Vector3.right)
			{
				vector += Vector3.forward * 10f;
			}
			else if (obstacle.forward == -Vector3.right)
			{
				vector -= Vector3.forward * 10f;
			}
			return vector;
		}

		public static bool ShowRewardAds()
		{
			return false;
		}
		public static bool ShowBannerAds()
		{
			bool result = false;
			UnityEngine.Debug.Log("Show Banner; " + result.ToString());
			return result;
		}

		public static bool ShowIntertitialAds()
		{
			bool result = false;
			UnityEngine.Debug.Log("Show Intertitial; " + result.ToString());
			return result;
		}

		public static bool inisilizeAds()
		{
			bool result = false;
			UnityEngine.Debug.Log("Inisilize Ads; " + result.ToString());
			return result;
		}

		public static bool IsGrounded(Transform PointTarget)
		{
			float num = 0.1f;
			Ray ray = new Ray(PointTarget.position, Vector3.down);
			UnityEngine.Debug.DrawRay(ray.origin, ray.direction * num, Color.green);
			if (Physics.Raycast(ray, num))
			{
				return true;
			}
			return false;
		}

		public static bool IsObstacleFacing(Transform directionPlayer)
		{
			if (Physics.Raycast(directionPlayer.position, directionPlayer.forward, out RaycastHit _, 1f))
			{
				return true;
			}
			return false;
		}

		public static RaycastHit IsArrivedTarget(Transform TargetObject, MoveDirectoin Mode, float Distance, Vector3 Offest, LayerMask layersToSkip)
		{
			Vector3 vector = Vector3.zero;
			switch (Mode)
			{
			case MoveDirectoin.Left:
				vector = -TargetObject.right;
				break;
			case MoveDirectoin.Right:
				vector = TargetObject.right;
				break;
			case MoveDirectoin.Forback:
				vector = -TargetObject.forward;
				break;
			case MoveDirectoin.Forward:
				vector = TargetObject.forward;
				break;
			}
			Vector3 vector2 = TargetObject.position + Offest;
			if (Physics.Raycast(vector2, vector, out RaycastHit hitInfo, Distance, ~(int)layersToSkip))
			{
				UnityEngine.Debug.DrawLine(vector2, hitInfo.point, Color.red);
				return hitInfo;
			}
			UnityEngine.Debug.DrawRay(vector2, vector * Distance, Color.green);
			return hitInfo;
		}

		public static bool CheckingManagementDistination(Transform Parent)
		{
			Vector3 forward = Parent.forward;
			float num = -20f;
			float num2 = 20f;
			float num3 = 2f;
			bool result = false;
			float d = 2f;
			for (float num4 = num; num4 <= num2; num4 += num3)
			{
				Quaternion rotation = Quaternion.AngleAxis(num4, Vector3.up);
				Ray ray = new Ray(Parent.localPosition + forward * d + new Vector3(0f, 1f, 0f), rotation * forward);
				UnityEngine.Debug.DrawRay(ray.origin, ray.direction * 10f, Color.Lerp(Color.blue, Color.red, (num4 - num) / (num2 - num)));
				RaycastHit hitInfo;
				if (Physics.Raycast(ray, out hitInfo, 10f) && hitInfo.collider != null && (hitInfo.collider.gameObject.GetComponent<YelbCharacter>() != null || hitInfo.collider.CompareTag("Player")))
				{
					result = true;
					break;
				}
			}
			return result;
		}

		public static int GetValueFromInt(string ID)
		{
			return PlayerPrefs.GetInt(ID);
		}

		public static int ExtractNumberFromString(string input)
		{
			int num = 0;
			bool flag = false;
			foreach (char c in input)
			{
				if (char.IsDigit(c))
				{
					num = num * 10 + (c - 48);
					flag = true;
				}
				else if (flag)
				{
					break;
				}
			}
			return num;
		}

		public static string GetValueFromString(string ID)
		{
			return PlayerPrefs.GetString(ID);
		}

		public static string FormatNumber(int number)
		{
			string[] array = new string[5]
			{
				"",
				"K",
				"M",
				"B",
				"T"
			};
			int num = 0;
			float num2 = number;
			while (num2 >= 1000f && num < array.Length - 1)
			{
				num2 /= 1000f;
				num++;
			}
			return num2.ToString("0.#") + array[num];
		}

		public static string CurrentYear()
		{
			return DateTime.Now.Year.ToString();
		}

		public static string CurrentDay()
		{
			return DateTime.Now.Day.ToString();
		}

		public static string CurrentMonth()
		{
			return DateTime.Now.Month.ToString();
		}

		public static string GetLastVersionUrl(string owner, string repo)
		{
			using (UnityWebRequest unityWebRequest = UnityWebRequest.Get("https://api.github.com/repos/" + owner + "/" + repo + "/releases/latest"))
			{
				unityWebRequest.SetRequestHeader("User-Agent", "Unity Web Request");
				unityWebRequest.SendWebRequest();
				while (!unityWebRequest.isDone)
				{
				}
				if (unityWebRequest.result == UnityWebRequest.Result.Success)
				{
					return JsonUtility.FromJson<ReleaseData>(unityWebRequest.downloadHandler.text).html_url;
				}
				UnityEngine.Debug.LogError("Failed to fetch latest release. Error: " + unityWebRequest.error);
			}
			return "";
		}

		public static float GetValueFromFloat(string ID)
		{
			return PlayerPrefs.GetFloat(ID);
		}

		public static float GetVolume(VolumeMode Mode)
		{
			switch (Mode)
			{
			case VolumeMode.sound:
				return PlayerPrefs.GetFloat("YelbSound");
			case VolumeMode.music:
				return PlayerPrefs.GetFloat("YelbMusic");
			case VolumeMode.effect:
				return PlayerPrefs.GetFloat("YelbEffect");
			default:
				return 0f;
			}
		}

		public static float MovementSpeedAnim()
		{
			float num = 0f;
			float x = InputAxis(ModeSelection.movement).x;
			float y = InputAxis(ModeSelection.movement).y;
			num = ((!(x > 0f)) ? (num + (0f - x)) : (num + x));
			num = ((!(y > 0f)) ? (num + (0f - y)) : (num + y));
			return num / 2f;
		}

		public static float GetAnimationLength(Animator animator, string animationClipName)
		{
			if (animator == null)
			{
				return 0f;
			}
			AnimatorClipInfo[] currentAnimatorClipInfo = animator.GetCurrentAnimatorClipInfo(0);
			for (int i = 0; i < currentAnimatorClipInfo.Length; i++)
			{
				AnimatorClipInfo animatorClipInfo = currentAnimatorClipInfo[i];
				if (animatorClipInfo.clip.name == animationClipName)
				{
					return animatorClipInfo.clip.length;
				}
			}
			return 0f;
		}

		public static Button[] FindAllButtons()
		{
			return UnityEngine.Object.FindObjectsOfType<Button>();
		}

		public static AudioSource[] FindAllSources()
		{
			return UnityEngine.Object.FindObjectsOfType<AudioSource>();
		}

		public static GameObject[] FindAllObjectWithTag(string tag)
		{
			return GameObject.FindGameObjectsWithTag(tag);
		}

		public static GameObject[] FindAllObjectWithBehavor<T>() where T : MonoBehaviour
		{
			List<GameObject> list = new List<GameObject>();
			GameObject[] array = UnityEngine.Object.FindObjectsOfType<GameObject>(includeInactive: true);
			foreach (GameObject gameObject in array)
			{
				if ((UnityEngine.Object)gameObject.GetComponent<T>() != (UnityEngine.Object)null)
				{
					list.Add(gameObject);
				}
			}
			return list.ToArray();
		}

		public static GameObject FindObjectWithName(string Name)
		{
			return GameObject.Find(Name);
		}

		public static GameObject FindObjectWithTag(string Tag)
		{
			return GameObject.FindGameObjectWithTag(Tag);
		}

		public static Collider FindRayCheckingColliders(float DistanceRay, string FindingType, Transform PointStart, FindingMode Mode)
		{
			UnityEngine.Debug.DrawRay(PointStart.position, PointStart.forward * DistanceRay, Color.red);
			if (Physics.Raycast(PointStart.position, PointStart.forward, out RaycastHit hitInfo, DistanceRay))
			{
				switch (Mode)
				{
				case FindingMode.WithTag:
				{
					bool flag = hitInfo.collider.tag == FindingType;
					return hitInfo.collider;
				}
				case FindingMode.withName:
				{
					bool flag2 = hitInfo.collider.gameObject.name == FindingType;
					return hitInfo.collider;
				}
				default:
					return hitInfo.collider;
				}
			}
			return null;
		}

		public static void MoveObjectLoop(Transform Target, float moveSpeed, Vector3 StartPos, Vector3 EndPos)
		{
			float t = Mathf.PingPong(Time.time * moveSpeed, 1f);
			Target.position = Vector3.Lerp(StartPos, EndPos, t);
		}

		public static void ActionWindow(GameObject OBJ)
		{
			OBJ.SetActive(!OBJ.activeSelf);
		}

		public static void CameraLooking(Transform Target, Transform Camera, float SmoothValue, float SensitiveX, float SensitiveY, Vector3 Offset, CameraMods Mode)
		{
			CameraTrigger component = Camera.GetComponent<CameraTrigger>();
			if (component == null)
			{
				Camera.gameObject.AddComponent<CameraTrigger>();
			}
			float x = InputAxis(ModeSelection.rotation).x;
			float y = InputAxis(ModeSelection.rotation).y;
			Quaternion identity = Quaternion.identity;
			Vector3 b = Target.position + Offset;
			switch (Mode)
			{
			case CameraMods.top:
				identity = Quaternion.LookRotation(new Vector3(Target.position.x - Camera.position.x, 0f, Target.position.z - Camera.position.z));
				break;
			case CameraMods.down:
				identity = Quaternion.LookRotation(new Vector3(Target.position.x - Camera.position.x, 0f, Target.position.z - Camera.position.z));
				break;
			case CameraMods.fps:
				Camera.transform.Rotate(Vector3.up, x * SensitiveX, Space.World);
				Camera.transform.Rotate(Vector3.left, y * SensitiveY, Space.Self);
				identity = Camera.transform.rotation;
				break;
			case CameraMods.tps:
				identity = Quaternion.Euler(34f, 0f, 0f);
				break;
			default:
				UnityEngine.Debug.LogError("Unsupported camera mode!");
				return;
			}
			if (component != null)
			{
				bool flag = component.AvoidePoint != Vector3.zero;
			}
			Camera.position = Vector3.Lerp(Camera.position, b, SmoothValue * Time.deltaTime);
			Camera.rotation = Quaternion.Slerp(Camera.rotation, identity, SmoothValue * Time.deltaTime);
		}

		public static void SetTargetDirection(Transform Target, Transform Player, LineRenderer Render, NavMeshData DataMesh)
		{
			NavMeshPath navMeshPath = new NavMeshPath();
			NavMesh.CalculatePath(Player.position, Target.position, -1, navMeshPath);
			List<Vector3> list = new List<Vector3>(navMeshPath.corners);
			if (list.Count > 1)
			{
				Render.positionCount = list.Count;
				Render.SetPositions(list.ToArray());
			}
		}

		public static void StartAnimation(Animator anim, string Animation, float Speed, AnimationMode Mode)
		{
			if (anim != null && anim.gameObject.activeSelf && anim.enabled)
			{
				switch (Mode)
				{
				case AnimationMode.normal:
					anim.speed = Speed;
					anim.Play(Animation);
					break;
				case AnimationMode.setbool:
				{
					bool value = false;
					if (Speed == 1f)
					{
						value = true;
					}
					anim.SetBool(Animation, value);
					break;
				}
				case AnimationMode.setfloat:
					anim.SetFloat(Animation, Speed);
					break;
				case AnimationMode.setint:
					anim.SetInteger(Animation, (int)Speed);
					break;
				}
			}
			else
			{
				UnityEngine.Debug.Log("Animator Is Disabled For: " + anim.gameObject.name);
			}
		}

		public static void DestroyItem(GameObject OBJ)
		{
			OBJ.name = "";
			OBJ.tag = "Untagged";
			OBJ.layer = 0;
			OBJ.SetActive(value: false);
			UnityEngine.Object.DestroyImmediate(OBJ.gameObject);
		}

		public static void StartTiming(GameObject OBJ, float Time)
		{
			GameObject gameObject = new GameObject();
			gameObject.SetActive(value: false);
			gameObject.AddComponent<ReferenceCourotine>();
			gameObject.GetComponent<ReferenceCourotine>().TimeTake = Time;
			gameObject.name = "YelbouzianiCounter: " + Time.ToString();
			gameObject.GetComponent<ReferenceCourotine>().StartCoroutine(gameObject.GetComponent<ReferenceCourotine>().ActionTake(OBJ));
		}

		public static void SaveData(string ID, string Information, DataType Mode)
		{
			switch (Mode)
			{
			case DataType.stringV:
				PlayerPrefs.SetString(ID, Information);
				break;
			case DataType.floatV:
				PlayerPrefs.SetFloat(ID, float.Parse(Information));
				break;
			case DataType.IntV:
				PlayerPrefs.SetInt(ID, int.Parse(Information));
				break;
			}
		}

		public static void SetVolume(float Value, VolumeMode Mode)
		{
			switch (Mode)
			{
			case VolumeMode.sound:
				PlayerPrefs.SetFloat("YelbSound", Value);
				break;
			case VolumeMode.music:
				PlayerPrefs.SetFloat("YelbMusic", Value);
				break;
			case VolumeMode.effect:
				PlayerPrefs.SetFloat("YelbEffect", Value);
				break;
			}
		}

		public static void LoadSceneMode(SceneLoadMode Mode, int Value = 0)
		{
			switch (Mode)
			{
			case SceneLoadMode.next:
				SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
				break;
			case SceneLoadMode.back:
				SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex - 1);
				break;
			case SceneLoadMode.target:
				SceneManager.LoadScene(Value);
				break;
			case SceneLoadMode.refesh:
				SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
				break;
			}
		}

		public static void ChangeSpriteModeFromFloat(Sprite Active, Sprite Inactive, Image Manager, float Value)
		{
			if (Value == 0f)
			{
				Manager.sprite = Inactive;
			}
			if (Value == 1f)
			{
				Manager.sprite = Active;
			}
		}

		public static void LogInfo(string msg)
		{
			Console.WriteLine(msg);
		}

		public static void SaveTime()
		{
			string information = DateTime.Now.ToString("HH:mm:ss");
			SaveData("TimeTravel", information, DataType.stringV);
		}

		public static void SaveInfroamtion(string DataMode, string DataValue, string Parameter)
		{
			SaveData(DataMode, DataValue, DataType.stringV);
			SaveData(Parameter, DataMode, DataType.stringV);
		}

		public static void APTransform(ModeTransform Mode, Transform Parent, Transform Target)
		{
			switch (Mode)
			{
			case ModeTransform.localposition:
				Parent.localPosition = Target.localPosition;
				break;
			case ModeTransform.localrotation:
				Parent.localRotation = Target.localRotation;
				break;
			case ModeTransform.position:
				Parent.position = Target.position;
				break;
			case ModeTransform.rotation:
				Parent.rotation = Target.rotation;
				break;
			}
		}

		public static void SearchObjectsFixation()
		{
			GameObject[] array = UnityEngine.Object.FindObjectsOfType<GameObject>(includeInactive: true);
			foreach (GameObject gameObject in array)
			{
				if (gameObject.name.StartsWith("TSP_Rug") && gameObject.GetComponent<NavMeshObstacle>() != null)
				{
					UnityEngine.Object.Destroy(gameObject.GetComponent<NavMeshObstacle>());
				}
			}
		}

		public static string GetSavedTime()
		{
			return GetValueFromString("TimeTravel");
		}

		public static string CurrentTime()
		{
			return DateTime.Now.ToString("HH:mm:ss");
		}

		public static string TimeLeft()
		{
			TimeSpan t = CalculateTimeDifference();
			TimeSpan timeSpan = TimeSpan.FromHours(24.0) - t;
			if (t.TotalDays >= 1.0)
			{
				return "Finish";
			}
			return timeSpan.ToString().Substring(0, Math.Min(8, timeSpan.ToString().Length));
		}

		public static TimeSpan CalculateTimeDifference()
		{
			DateTime d = DateTime.ParseExact(GetSavedTime(), "HH:mm:ss", null);
			return DateTime.Now - d;
		}
	}
}
