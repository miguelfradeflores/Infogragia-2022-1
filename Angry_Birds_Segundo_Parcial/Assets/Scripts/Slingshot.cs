using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Slingshot : MonoBehaviour
{
    /*
    public Vector3 currentPosition;

    public float maxLength;

    public float bottomBoundary;

    bool isMouseDown;

    public GameObject redPrefab;

    public float redPositionOffset;

    Rigidbody2D red;
    Collider2D redCollider;

    public float force;

    void Start()
    {
        CreateRed();
    }

    void CreateRed()
    {
        red = Instantiate(redPrefab).GetComponent<Rigidbody2D>();
        redCollider = red.GetComponent<Collider2D>();
        redCollider.enabled = false;

        red.isKinematic = true;

    }

    void Update()
    {
        if (isMouseDown)
        {
            Vector3 mousePosition = Input.mousePosition;
            mousePosition.z = 10;

            currentPosition = Camera.main.ScreenToWorldPoint(mousePosition);
            /*currentPosition = center.position + Vector3.ClampMagnitude(currentPosition
                - center.position, maxLength);

            currentPosition = ClampBoundary(currentPosition);


            if (redCollider)
            {
                redCollider.enabled = true;
            }
        }
        else
        {

        }
    }

    private void OnMouseDown()
    {
        isMouseDown = true;
    }

    private void OnMouseUp()
    {
        isMouseDown = false;
        Shoot();
        //currentPosition = idlePosition.position;
    }

    void Shoot()
    {
        red.isKinematic = false;
        //Vector3 redForce = (currentPosition - center.position) * force * -1;
        red.velocity = redForce;

        red.GetComponent<Red>().Release();

        red = null;
        redCollider = null;
        Invoke("CreateRed", 2);
    }


    Vector3 ClampBoundary(Vector3 vector)
    {
        vector.y = Mathf.Clamp(vector.y, bottomBoundary, 1000);
        return vector;
    }*/
}
