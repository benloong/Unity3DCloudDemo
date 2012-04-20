using UnityEngine;
using System.Collections;

public class Cloud : MonoBehaviour {
	
	private float offset = 0;
	public float scrollSpeed = 0.001f;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		transform.position  = Camera.main.transform.position;
		
		offset += Time.deltaTime * scrollSpeed;
		renderer.material.SetFloat("_Offset", offset);
	}
}
