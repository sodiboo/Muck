using System.Linq;
using Steamworks;
using Steamworks.Data;
using UnityEngine;

public class AchievementDisplay : MonoBehaviour
{
    public enum WinState
    {
        Won = -3,
        Lost,
        Draw
    }

    public GameObject achievementPrefab;

    public Transform achievementParent;

    private int achievementsPerPage = 8;

    private int nAchievements;

    private int nPages;

    private int currentPage;

    private Achievement[] achievements = new Achievement[0];

    private void OnEnable()
    {
        currentPage = 0;
        if (achievements.Length < 1)
        {
            achievements = SteamUserStats.Achievements.ToArray();
        }
        nAchievements = achievements.Length;
        nPages = Mathf.FloorToInt((float)nAchievements / (float)achievementsPerPage);
        LoadPage(currentPage);
    }

    private void LoadPage(int page)
    {
        for (int num = achievementParent.childCount - 1; num >= 0; num--)
        {
            Object.Destroy(achievementParent.GetChild(num).gameObject);
        }
        int num2 = achievementsPerPage * page;
        for (int i = num2; i < achievements.Length; i++)
        {
            Object.Instantiate(achievementPrefab, achievementParent).GetComponent<AchievementPrefab>().SetAchievement(achievements[i]);
            if (i >= num2 + achievementsPerPage - 1)
            {
                break;
            }
        }
    }

    public void NextPage(int dir)
    {
        if ((dir >= 0 || currentPage != 0) && (dir <= 0 || currentPage < nPages))
        {
            currentPage += dir;
            LoadPage(currentPage);
        }
    }
}
