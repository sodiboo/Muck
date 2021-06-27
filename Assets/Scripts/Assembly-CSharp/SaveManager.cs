using System;
using System.IO;
using System.Xml.Serialization;
using UnityEngine;

// Token: 0x020000DF RID: 223
public class SaveManager : MonoBehaviour
{
	// Token: 0x17000053 RID: 83
	// (get) Token: 0x060006F1 RID: 1777 RVA: 0x00024161 File Offset: 0x00022361
	// (set) Token: 0x060006F2 RID: 1778 RVA: 0x00024168 File Offset: 0x00022368
	public static SaveManager Instance { get; set; }

	// Token: 0x060006F3 RID: 1779 RVA: 0x00024170 File Offset: 0x00022370
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

	// Token: 0x060006F4 RID: 1780 RVA: 0x000241A5 File Offset: 0x000223A5
	public void Save()
	{
		PlayerPrefs.SetString("save", this.Serialize<PlayerSave>(this.state));
	}

	// Token: 0x060006F5 RID: 1781 RVA: 0x000241BD File Offset: 0x000223BD
	public void Load()
	{
		if (PlayerPrefs.HasKey("save"))
		{
			this.state = this.Deserialize<PlayerSave>(PlayerPrefs.GetString("save"));
			return;
		}
		this.NewSave();
	}

	// Token: 0x060006F6 RID: 1782 RVA: 0x000241E8 File Offset: 0x000223E8
	public void NewSave()
	{
		this.state = new PlayerSave();
		this.Save();
		MonoBehaviour.print("Creating new save file");
	}

	// Token: 0x060006F7 RID: 1783 RVA: 0x00024208 File Offset: 0x00022408
	public string Serialize<T>(T toSerialize)
	{
		XmlSerializer xmlSerializer = new XmlSerializer(typeof(T));
		StringWriter stringWriter = new StringWriter();
		xmlSerializer.Serialize(stringWriter, toSerialize);
		return stringWriter.ToString();
	}

	// Token: 0x060006F8 RID: 1784 RVA: 0x0002423C File Offset: 0x0002243C
	public T Deserialize<T>(string toDeserialize)
	{
		XmlSerializer xmlSerializer = new XmlSerializer(typeof(T));
		StringReader textReader = new StringReader(toDeserialize);
		return (T)((object)xmlSerializer.Deserialize(textReader));
	}

	// Token: 0x04000682 RID: 1666
	public PlayerSave state;
}
