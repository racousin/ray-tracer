#ifndef PARSER_H
# define PARSER_H

# include "shared.h"

enum	e_errors
{
	ERR_FILE_OPEN,
	ERR_FILE_SYNTAX,
	ERR_NO_ENTITY,
	ERR_UNKNOWN_OBJ,
	ERR_WRONG_ARGS
};

typedef struct			s_parser_cam
{
	t_vec3				pos;
	t_vec3				look_at;
	t_vec3				up;
}						t_parser_cam;


typedef struct			s_env
{
	t_parser_cam		camera;
	t_list				*objects;
	t_list				**current_object;
	size_t				depth;
	char				*ln;
	int					fd;
	int					object_type;
	char				error_text[80];
}						t_env;

void					ft_puterr(int err, t_env *env);
void					ft_read_file(char *name, t_env *env);

t_vec3					p_read_vec3(char *ln);
void					p_parse_object(t_env *env);
void					p_parse_camera(t_env *env);
enum e_object_type		p_str_to_type(char *str);
size_t					count_tab(char *ln);

#endif
