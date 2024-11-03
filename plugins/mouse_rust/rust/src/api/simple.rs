use enigo::{Enigo, Settings, Coordinate, Mouse};


#[flutter_rust_bridge::frb(sync)]
pub fn move_mouse(x: f64, y: f64) {
    let mut enigo = Enigo::new(&Settings::default()).unwrap();

    let _ = enigo.move_mouse(x as i32, y as i32, Coordinate::Rel);
}
// #[flutter_rust_bridge::frb(sync)]
// pub fn scroll_mouse(_x: f64, _y: f64) {}

#[flutter_rust_bridge::frb(sync)]
pub fn get_mouse_pos() -> (i32, i32) {
    let enigo = Enigo::new(&Settings::default()).unwrap();

    match enigo.location() {
        Ok((x, y)) => (x, y),
        Err(_) => (0, 0), // Retorna (0, 0) se houver erro, mas pode tratar de outra forma
    }
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
