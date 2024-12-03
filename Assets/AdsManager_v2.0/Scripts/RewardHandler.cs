using UnityEngine;

public class RewardHandler : MonoBehaviour
{
    public static RewardHandler instance;

    [HideInInspector] public bool isRewardAvailableCheck;

    public delegate void RewardedCompleteCheck();


    public static RewardedCompleteCheck OnRewardComplete;
    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
        else if (instance != null)
        {
            Destroy(gameObject);
        }
    }
    public void GiveReward()
    {
        OnRewardComplete?.Invoke();
    }

}
public enum RvState
{
    Cash,FastDelivery,Synergy,UnlockRack
}