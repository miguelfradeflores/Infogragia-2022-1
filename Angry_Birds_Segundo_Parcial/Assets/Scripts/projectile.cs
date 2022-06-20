using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class projectile : MonoBehaviour
{
    private Rigidbody2D rb;
    private SpringJoint2D springJoint;
    private bool isPressed;

    public GameObject groguPrefab;
    // Start is called before the first frame update
    void Start()
    {
        //isPressed = false;
        //CreateGrogu();
        Debug.Log("Start method called.");
        rb = GetComponent<Rigidbody2D>();
        springJoint = GetComponent<SpringJoint2D>();
    }

    // Update is called once per frame
    void Update()
    {
        //Debug.Log("Update method calling.");
        if (isPressed)
        {
            rb.position = Camera.main.ScreenToWorldPoint(Input.mousePosition);
        }
    }

    void CreateGrogu()
    {
        rb = Instantiate(groguPrefab).GetComponent<Rigidbody2D>();

        rb.isKinematic = true;

    }

    void OnMouseDown()
    {
        isPressed = true;
        rb.isKinematic = true;
    }
    void OnMouseUp()
    {
        isPressed = false;
        rb.isKinematic = false;

        StartCoroutine(Release());

        //Invoke("CreateGrogu", 2);
        //Shoot();
    }

    void Shoot()
    {
        rb.isKinematic = false;
        //Vector3 redForce = (currentPosition - center.position) * force * -1;
        //red.velocity = redForce;

        //rb.GetComponent<Red>().Release();

        rb = null;
        //redCollider = null;
        Invoke("CreateGrogu", 2);
    }

    IEnumerator Release()
    {
        yield return new WaitForSeconds(0.15f);

        GetComponent<SpringJoint2D>().enabled = false;
    }
}
