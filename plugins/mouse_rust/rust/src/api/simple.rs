use enigo::{
    Button, Coordinate,
    Direction::{Click, Press, Release},
    Enigo, Mouse, Settings,
};

#[flutter_rust_bridge::frb(sync)]
pub fn mouse_move(x: f64, y: f64) {
    let mut enigo = Enigo::new(&Settings::default()).unwrap();

    let _ = enigo.move_mouse(x as i32, y as i32, Coordinate::Rel);
}

// #[flutter_rust_bridge::frb(sync)]
// pub fn mouse_click(value: i32) {
//     let mut enigo = Enigo::new(&Settings::default()).unwrap();

//     // match value {
//     //     0 => enigo.button(Button::Left, Click), // Clique do botão esquerdo
//     //     1 => enigo.button(Button::Middle, Click), // Clique do botão do meio
//     //     2 => enigo.button(Button::Right, Click), // Clique do botão direito
//     // }
//     // Inicializa uma variável `button` com um valor padrão
//     let button = match value {
//         0 => Button::Left,
//         1 => Button::Middle,
//         2 => Button::Right,
//         _ => Button::Left, // Retorna um erro se o valor for inválido
//     };

//     // Realiza o clique usando a variável `button`
//     enigo.button(button, Click);
// }

// #[flutter_rust_bridge::frb(sync)]
// pub fn mouse_press(value: i32) {
//     let mut enigo = Enigo::new(&Settings::default()).unwrap();

//     match value {
//         0 => enigo.button(Button::Left, Press), // Clique do botão esquerdo
//         1 => enigo.button(Button::Middle, Press), // Clique do botão do meio
//         2 => enigo.button(Button::Right, Press), // Clique do botão direito
//                                                  // _ => println!("Valor inválido: {}", value), // Caso para valores inválidos
//     }
// }

// #[flutter_rust_bridge::frb(sync)]
// pub fn mouse_release(value: i32) {
//     let mut enigo = Enigo::new(&Settings::default()).unwrap();

//     match value {
//         0 => enigo.button(Button::Left, Release), // Clique do botão esquerdo
//         1 => enigo.button(Button::Middle, Release), // Clique do botão do meio
//         2 => enigo.button(Button::Right, Release), // Clique do botão direito
//     }
// }

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}
