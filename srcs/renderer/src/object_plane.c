/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   object_plane.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: vfour <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2017/01/21 17:46:56 by vfour             #+#    #+#             */
/*   Updated: 2017/02/06 16:57:11 by vfour            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <math.h>
#include <stdlib.h>
#include <libft.h>
#include "rtv1.h"

/*
** Intersection between ray and plane
** @return the distance between camera and object if there is collision
** or a negative value otherwise
*/

static int		plane_intersect(t_obj *self, t_ray *ray)
{
	t_vec3		x;
	t_f			a;
	t_f			b;
	t_f			d;

	b = vec3_dot(ray->dir, self->dir);
	if (fabs(b) < EPS)
		return (0);
	x = vec3_sub(self->pos, ray->pos);
	a = vec3_dot(x, self->dir);
	d = a / b;
	if (d < ray->d && d > 0)
	{
		ray->d = d;
		if (ray->type == INITIAL_RAY)
			ray->collided = self;
		return (1);
	}
	return (0);
}

/*
** Normal vector at given point
** @return normal direction
*/

static t_vec3	plane_normal(t_obj *self, t_vec3 pos)
{
	if (vec3_dot(vec3_sub(pos, self->pos), self->dir) > 0)
		return (self->dir);
	return (vec3_mult(-1, self->dir));
}

static t_obj	*check_plane(t_obj *o)
{
	if (!float_checkbounds(o->color.r, 0, 1)
		|| !float_checkbounds(o->color.g, 0, 1)
		|| !float_checkbounds(o->color.b, 0, 1)
		|| !float_checkbounds(o->kp, 0, MAX_KP)
		|| !float_checkbounds(o->kspec, 0, MAX_KSPEC)
		|| !float_checkbounds(o->kdiff, 0, MAX_KDIFF))
	{
		ft_putendl("Plane : out of bound value");
		free(o);
		return (NULL);
	}
	return (o);
}

/*
** Plane constructor
** @return a pointer to a new struct plane, or null
*/

t_obj			*plane_new(char **t)
{
	t_obj		*o;
	t_f			color_normalize;

	if (NULL == (o = (t_obj*)ft_memalloc(sizeof(t_obj))))
		ft_exit("Malloc error in Plane constructor", EXIT_FAILURE);
	color_normalize = 1. / 255.;
	o->pos = (t_vec3){ft_atof(*t), ft_atof(*(t + 1)), ft_atof(*(t + 2))};
	o->dir = (t_vec3){ft_atof(*(t + 3)), ft_atof(*(t + 4)), ft_atof(*(t + 5))};
	vec3_normalize(&(o->dir));
	o->color.r = (t_f)ft_atoi(*(t + 6)) * color_normalize;
	o->color.g = (t_f)ft_atoi(*(t + 7)) * color_normalize;
	o->color.b = (t_f)ft_atoi(*(t + 8)) * color_normalize;
	o->kspec = ft_atof(*(t + 9));
	o->kdiff = ft_atof(*(t + 10));
	o->kp = ft_atof(*(t + 11));
	o->intersect = &plane_intersect;
	o->normal = &plane_normal;
	return (check_plane(o));
}
