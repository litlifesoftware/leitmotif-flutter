// Copyright 2021 LitLifeSoftware. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// A collection of Flutter widgets.
///
///
/// To use, import `package:lit_ui_lit/lit_ui_kit.dart`.
///
/// Dependencies used:
///
/// * package_info
/// * url_launcher
/// * intl
///
/// To use the above mentioned dependencies, please include them
/// separatly on the `pubspec.yaml` of your project. These will not be
/// exported to avoid any namespace issues.
library lit_ui_kit;

/// Animated Buttons
export 'src/widgets/action_buttons/animated_action_button.dart';
export 'src/widgets/action_buttons/custom_action_button.dart';
export 'src/widgets/action_buttons/dummy_action_button.dart';
export 'src/widgets/action_buttons/animated_action_button.dart';
export 'src/widgets/action_buttons/collapse_on_scroll_action_button.dart';

/// App bars
export 'src/widgets/app_bars/custom_app_bar.dart';
export 'src/widgets/app_bars/lit_app_bar.dart';
export 'src/widgets/app_bars/lit_blurred_app_bar.dart';
export 'src/widgets/app_bars/fixed_on_scroll_appbar.dart';
export 'src/widgets/app_bars/minimalist_app_bar.dart';

// Art
export 'art.dart';

/// Badges
export 'src/widgets/badges/lit_badge.dart';

/// Bottom navigation
export 'src/widgets/bottom_navigation/lit_bottom_navigation.dart';

/// Buttons
export 'src/widgets/buttons/lit_tooltip_button.dart';
export 'src/widgets/buttons/lit_back_button.dart';
export 'src/widgets/buttons/circular_close_button.dart';
export 'src/widgets/buttons/lit_transform_animated_button.dart';
export 'src/widgets/buttons/lit_rounded_outlined_button.dart';
export 'src/widgets/buttons/lit_rounded_flat_button.dart';
export 'src/widgets/buttons/lit_rounded_elevated_button.dart';
export 'src/widgets/buttons/lit_toggle_button.dart';
export 'src/widgets/buttons/lit_switch_button.dart';
export 'src/widgets/buttons/lit_pushed_button.dart';
export 'src/widgets/buttons/lit_pushed_through_button.dart';
export 'src/widgets/buttons/lit_gradient_button.dart';
export 'src/widgets/buttons/dialog_back_button.dart';
export 'src/widgets/buttons/lit_bubble_button.dart';
export 'src/widgets/buttons/lit_glowing_button.dart';
export 'src/widgets/buttons/lit_plain_label_button.dart';

/// Collapsibles
export 'src/widgets/collapsible_card/collapsible_card_controller.dart';
export 'src/widgets/collapsible_card/collapsible_card.dart';
export 'src/widgets/collapsible_card/dummy_collapsible_card.dart';
export 'src/widgets/collapsible_card/titled_collapsible_card.dart';

/// Colors
export 'src/styles/lit_colors.dart';

/// Containers
export 'src/widgets/containers/fade_in_transform_container.dart';
export 'src/widgets/containers/fade_in_transform_scale_container.dart';
export 'src/widgets/containers/blured_background_container.dart';
export 'src/widgets/containers/scrollable_column.dart';
export 'src/widgets/containers/on_value_changed_animated_container.dart';
export 'src/widgets/containers/lit_constrained_size_box.dart';
export 'src/widgets/containers/lit_elevated_card.dart';
export 'src/widgets/containers/lit_gradient_card.dart';
export 'src/widgets/containers/lit_notification_container.dart';
export 'src/widgets/containers/lit_elevated_glass_card.dart';
export 'src/widgets/backgrounds/lit_animated_gradient_background.dart';
export 'src/widgets/containers/lit_slider_card.dart';
export 'src/widgets/containers/lit_draggable.dart';
export 'src/widgets/containers/lit_footer.dart';
export 'src/widgets/containers/clean_ink_well.dart';

/// Controllers
export 'src/controller/lit_notification_controller.dart';
export 'src/controller/lit_route_controller.dart';
export 'src/controller/lit_focus_controller.dart';

/// Date picker
export 'date_picker.dart';

/// Dialogs
export 'src/widgets/dialogs/about_app_dialog.dart';
export 'src/widgets/dialogs/lit_titled_dialog.dart';
export 'src/widgets/dialogs/lit_date_picker_dialog.dart';

/// Icons
export 'icons.dart';

/// Loading indicators
export 'loading_indicators.dart';
export 'src/widgets/page_views/indexed_page_view.dart';

/// Models
export 'src/model/lit_notification_data.dart';

/// Scaffold
export 'scaffold.dart';

/// Screens
export 'src/screens/title_screen.dart';
export 'src/screens/age_confirmation_screen/age_confirmation_screen.dart';
export 'src/screens/application_licenses_screen/application_licenses_screen.dart';
export 'src/screens/lit_privacy_policy_screen.dart';
export 'src/screens/lit_onboarding_screen.dart';
export 'src/screens/lit_offline_app_disclaimer_screen.dart';
export 'src/screens/lit_credits_screen.dart';
export 'src/screens/lit_sign_up_screen.dart';
export 'src/screens/photosensitive_disclaimer_screen.dart';
export 'src/screens/confirm_age_screen.dart';
export 'src/screens/lit_startup_screen.dart';

/// Scrollbars
export 'src/widgets/scrollbars/lit_scrollbar.dart';

/// Settings panel
export 'src/widgets/settings_panel/settings_panel.dart';

/// Sliders
export 'slider.dart';

/// Snackbars
export 'snackbars.dart';

/// Styles
export 'styles.dart';

/// Text
export 'text.dart';

/// Utility
export 'src/util/image_cache_controller.dart';
export 'src/util/hex_color_converter.dart';
export 'src/util/platform_info.dart';
export 'src/util/animation_on_scroll_controller.dart';
export 'src/util/calendar_controller.dart';
export 'src/util/calendar_localization_service.dart';
export 'src/util/lit_alternative_layout.dart';
export 'src/util/datetime_validation.dart';
export 'src/util/datetime_age_conversion.dart';
export 'src/util/localized_date.dart';
