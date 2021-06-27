using System;
using System.IO;
using System.Xml.Serialization;
using UnityEngine;

public class SaveManager : MonoBehaviour
{
	public static SaveManager Instance { get; set; }

	private void Awake()
	{
		if (SaveManager.Instance != null && SaveManager.Instance != this)
		{
			Destroy(base.gameObject);
		}
		else
		{
			SaveManager.Instance = this;
		}
		this.Load();
	}

	public void Save()
	{
		PlayerPrefs.SetString("save", this.Serialize<PlayerSave>(this.state));
	}

	public void Load()
	{
		if (PlayerPrefs.HasKey("save"))
		{
			this.state = this.Deserialize<PlayerSave>(PlayerPrefs.GetString("save"));
			return;
		}
		this.NewSave();
	}

	public void NewSave()
	{
		this.state = new PlayerSave();
		this.Save();
		MonoBehaviour.print("Creating new save file");
	}

	public string Serialize<T>(T toSerialize)
	{
		XmlSerializer xmlSerializer = new XmlSerializer(typeof(T));
		StringWriter stringWriter = new StringWriter();
		xmlSerializer.Serialize(stringWriter, toSerialize);
		return stringWriter.ToString();
	}

	public T Deserialize<T>(string toDeserialize)
	{
		XmlSerializer xmlSerializer = new XmlSerializer(typeof(T));
		StringReader textReader = new StringReader(toDeserialize);
		return (T)((object)xmlSerializer.Deserialize(textReader));
	}

	public PlayerSave state;
}
