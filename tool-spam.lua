local function meshLag()
    local Workspace = game:GetService("Workspace")
    
    for i = 1, 100 do
        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.FileMesh
        mesh.MeshId = "rbxassetid://94245942"  -- Complex mesh
        mesh.TextureId = "rbxassetid://94245943"
        
        local part = Instance.new("Part")
        part.Size = Vector3.new(5, 5, 5)
        part.Position = Vector3.new(
            math.random(-100, 100),
            math.random(10, 50),
            math.random(-100, 100)
        )
        mesh.Parent = part
        part.Parent = Workspace
    end
end
