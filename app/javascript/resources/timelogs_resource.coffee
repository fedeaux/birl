import BaseResource from './base_resource'
import Timelog from '../models/timelog'

class TimelogsResource extends BaseResource
  @model = -> Timelog

  planMyDay: (complete, params = {}) ->
    $.ajax
      url: @collectionUrl('/plan_my_day')
      type: 'post'
      data: params
      complete: complete

export default TimelogsResource
