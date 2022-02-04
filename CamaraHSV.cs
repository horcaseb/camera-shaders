using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[ExecuteInEditMode]
public class CamaraHSV : MonoBehaviour
{
    [SerializeField] Shader shader;
    [Range(0, 1)] public float factor;
    [Range(0, 1)] public float _A;

    Material materialactual;
    Material material {
        get {
            if (materialactual == null)
            {
                materialactual = new Material(shader);
                materialactual.hideFlags = HideFlags.HideAndDontSave;
            }
            return materialactual;
        }
    }

    // Start is called before the first frame update
    void Start()
    {
        if (!shader || !shader.isSupported)
        {
            enabled = false;
        }
    }

    void OnRenderImage(RenderTexture entrada, RenderTexture salida)
    {
        material.SetFloat("_Factor",factor);
        material.SetFloat("_A", _A);

        Graphics.Blit(entrada, salida, material);
    }
    void OnDisable()
    {
        if (materialactual)
        {
            DestroyImmediate(materialactual);
        }    
    }
}
