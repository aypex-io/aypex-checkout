/* eslint-disable no-undef */

import { Application } from '@hotwired/stimulus'

// Stimulus - Aypex Controllers
import InputCardValidationController from './input/card_validation_controller'
import InputDisabledController from './input/disabled_controller'
import FormStateController from './form/state_controller'
import FormValidationController from './form/validation_controller'
import ModalController from './modal_controller'
import ToastController from './toast_controller'

// Stimulus - Setup
window.Stimulus = Application.start()

Stimulus.register('input--card-validation', InputCardValidationController)
Stimulus.register('input--disable-enable', InputDisabledController)
Stimulus.register('form--state', FormStateController)
Stimulus.register('form--validation', FormValidationController)
Stimulus.register('modal', ModalController)
Stimulus.register('toast', ToastController)
