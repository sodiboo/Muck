using System;
using UnityEngine;


public class CarSkin : MonoBehaviour
{
    private void Awake()
    {
        if (skinsToChange.Length > 0)
        {
            var skin = skinsToChange[UnityEngine.Random.Range(0, skinsToChange.Length)].myArray;
            for (var i = 0; i < skin.Length;)
            {
                var rend = renderers[skin[i++]];
                var mats = rend.materials;
                mats[skin[i++]] = materials[skin[i++]];
                rend.materials = mats;
            }
        }
        Destroy(this);
    }

    
    public Renderer[] renderers;

    
    public Material[] materials;

    
    public CarSkin.SkinArray[] skinsToChange;

    
    [Serializable]
    public class SkinArray
    {
        
        public int[] myArray;
    }
}
