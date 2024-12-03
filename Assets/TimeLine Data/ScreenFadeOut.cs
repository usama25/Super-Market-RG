using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class ScreenFadeOut : MonoBehaviour
{
    public float fadeDuration = 1.0f; // Duration of the fade-in effect

    private Image screenImage; // Reference to the UI image component
    private Color originalColor; // Original color of the UI element

    void Start()
    {
        // Get the UI image component
        screenImage = GetComponent<Image>();

        // Set the original color (assuming white)
        originalColor = screenImage.color;

        // Start the fade-in effect
        StartCoroutine(FadeIn());
    }

    IEnumerator FadeIn()
    {
        // Gradually decrease alpha value from 1 to 0 over the duration
        float elapsedTime = 0.0f;
        Color currentColor = originalColor;
        while (elapsedTime < fadeDuration)
        {
            float alpha = 1.0f - (elapsedTime / fadeDuration);
            currentColor.a = alpha;
            screenImage.color = currentColor;
            elapsedTime += Time.deltaTime;
            yield return null;
        }

        // Ensure the alpha value is fully transparent
        currentColor.a = 0.0f;
        screenImage.color = currentColor;
    }
}