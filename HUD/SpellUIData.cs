using Godot;

namespace ddrcast.HUD;

public record SpellUiData
{
    public Texture2D FullTexture;
    public Texture2D IconTexture;
    public string SpellName;
    public int SpellId;
}