use rdev::{simulate, EventType};

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn move_mouse(x: f64, y: f64) {
    // Simulando o movimento do mouse
    if let Err(e) = simulate(&EventType::MouseMove { x, y }) {
        eprintln!("Erro ao mover o mouse: {}", e);
    }
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
