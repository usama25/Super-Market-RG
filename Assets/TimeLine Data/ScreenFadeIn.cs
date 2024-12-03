using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class ScreenFadeIn : MonoBehaviour
{
    public float fadeDuration = 1.0f; // Duration of the fade-out effect

    private Image screenImage; // Reference to the UI image component
    private Color originalColor; // Original color of the UI element

    void Start()
    {
        // Get the UI image component
        screenImage = GetComponent<Image>();

        // Set the original color (assuming white)
        originalColor = screenImage.color;

        // Start the fade-out effect
        StartCoroutine(FadeOut());
    }

    IEnumerator FadeOut()
    {
        // Gradually increase alpha value from 0 to 1 over the duration
        float elapsedTime = 0.0f;
        Color currentColor = originalColor;
        while (elapsedTime < fadeDuration)
        {
            float alpha = elapsedTime / fadeDuration;
            currentColor.a = alpha;
            screenImage.color = currentColor;
            elapsedTime += Time.deltaTime;
            yield return null;
        }

        // Ensure the alpha value is fully opaque
        currentColor.a = 1.0f;
        screenImage.color = currentColor;
    }
}
