using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class die : MonoBehaviour
{
    public GameObject Cerdito;
    public GameObject Pattern;

    void OnCollisionEnter2D(Collision2D collision)
    {
        if(collision.collider.tag == "Piso")
        {
            Destroy();
        }
    }

    void Destroy()
    {
        Destroy(Cerdito);
        Instantiate(Pattern, transform.position, Quaternion.identity);
    }
}
