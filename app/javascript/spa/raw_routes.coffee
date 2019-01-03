# TODO: Auto generate paths

export default {
  routes: [
    {
      path: '/exercises'
      view: 'exercises/index'
    }
    {
      path: '/exercises/:id'
      view: 'exercises/show',
    }
    {
      path: '/challenges'
      view: 'challenges/index'
    }
    {
      path: '/challenges/:id'
      view: 'challenges/show',
    }
    {
      path: '/progressions'
      view: 'progressions/index'
    }
    {
      path: '/progressions/:id'
      view: 'progressions/show',
    }
  ]
}
