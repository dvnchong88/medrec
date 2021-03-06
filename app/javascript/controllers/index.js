// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from '@hotwired/stimulus'
// import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
import Lightbox from 'stimulus-lightbox'

const application = Application.start()
application.register('lightbox', Lightbox)
const context = require.context("controllers", true, /_controller\.js$/)
application.load(definitionsFromContext(context))
