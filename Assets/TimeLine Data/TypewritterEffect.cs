using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TypewritterEffect : MonoBehaviour
{

	[TextArea(3, 10)]
	public string m_text;
	[Range(0.01f, 0.1f)]
	public float m_characterInterval; //(in secs)

	private string m_partialText;
	private float m_cumulativeDeltaTime;


	private Text m_label;

	void Awake()
	{
		m_label = GetComponent<Text>();
	}

	void Start()
	{
		m_partialText = "";
		m_cumulativeDeltaTime = 0;
	}

	void Update()
	{
		m_cumulativeDeltaTime += Time.deltaTime;
		while (m_cumulativeDeltaTime >= m_characterInterval && m_partialText.Length < m_text.Length)
		{
			m_partialText += m_text[m_partialText.Length];
			m_cumulativeDeltaTime -= m_characterInterval;
		}
		m_label.text = m_partialText;
	}

}