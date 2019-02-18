# TODO: Auto generate paths

export default {
  routes: [
    {
      path: ''
      view: 'trainings/index'
    }
    {
      path: '/exercises'
      view: 'exercises/index'
    }
    {
      path: '/exercises/new'
      view: 'exercises/new',
    }
    {
      path: '/exercises/:id'
      view: 'exercises/show',
    }
    {
      path: '/exercises/:id/edit'
      view: 'exercises/edit',
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
