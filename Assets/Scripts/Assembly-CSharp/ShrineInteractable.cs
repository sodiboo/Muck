using UnityEngine;

public class ShrineInteractable : MonoBehaviour
{
	public MeshRenderer[] lights;
	public Material lightMat;
	public bool started;
	public LayerMask whatIsGround;
	public GameObject destroyShrineFx;
}
