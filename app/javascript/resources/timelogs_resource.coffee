import BaseResource from './base_resource'
import Timelog from '../models/timelog'

class TimelogsResource extends BaseResource
  @model = -> Timelog

  planMyDay: (success, params = {}) ->
    $.ajax
      url: @collectionUrl('/plan_my_day')
      type: 'post'
      data: params
      success: success

export default TimelogsResource
