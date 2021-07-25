using UnityEngine;

public class TestScroll : MonoBehaviour
{
    public NoiseData noise;

    public TerrainData terrain;

    public bool ready;

    public static TestScroll Instance;

    private void Awake()
    {
        Instance = this;
        Invoke(nameof(GetReady), 4f);
    }

    private void GetReady()
    {
        ready = true;
    }

    private void Update()
    {
        if (ready && !(terrain.heightMultiplier > 300f))
        {
            terrain.heightMultiplier += 20f * Time.deltaTime;
        }
    }
}
