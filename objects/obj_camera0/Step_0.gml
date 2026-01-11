// --- CAMERA FOLLOW + MOUSE INFLUENCE ---

if (instance_exists(follow)) {
    // Posição alvo do player
    var target_x = follow.x;
    var target_y = follow.y;
    
    // Posição do mouse em relação à view
    var mouse_world_x = camera_get_view_x(cam) + device_mouse_x_to_gui(0);
    var mouse_world_y = camera_get_view_y(cam) + device_mouse_y_to_gui(0);

    // Fator de influência do mouse (0 = ignora, 1 = segue totalmente o mouse)
    var mouse_influence = 0.1; // 25% de deslocamento em direção ao mouse

    // Posição alvo da câmera (um pouco puxada em direção ao mouse)
    xTo = lerp(target_x, mouse_world_x, mouse_influence);
    yTo = lerp(target_y, mouse_world_y, mouse_influence);
}

x += (xTo - x) / 10;
y += (yTo - y) / 10;

// Atualiza posição da view
camera_set_view_pos(cam, x - view_w_half, y - view_h_half);
