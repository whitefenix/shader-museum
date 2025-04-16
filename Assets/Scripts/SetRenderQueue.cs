using UnityEngine;

public class SetRenderQueue : MonoBehaviour
{
    [SerializeField]
    private int[] Queues = { 2000 };
    
    //Note: Can either use renderqueues 5000 and 4999 to not have to change any other objects
    //OR 2000 and 1999 but then have to manually adjust other geometry with scripts, but seeing the effect in the editor
    protected void Awake()
    {
        SetVals();
    }

    private void OnValidate()
    {
        SetVals();
    }

    private void SetVals()
    {
        Material[] materials = GetComponent<Renderer>().sharedMaterials;
        for (int i = 0; i < materials.Length && i < Queues.Length; ++i)
        {
            materials[i].renderQueue = Queues[i];
        }
    }
}